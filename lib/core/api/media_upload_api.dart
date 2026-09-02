import 'package:edulab_b2b/widget_imports.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:logging/logging.dart';

final _log = Logger('MediaUploadApi');

/// Uploads a single file to `POST /media/upload/mobile` and returns the media
/// the backend created, or null if the upload failed.
///
/// This deliberately bypasses Chopper: [ApiProvider.getInterceptors] pins
/// `Content-Type: application/json` on every request, which would clobber the
/// `multipart/form-data` boundary header.
class MediaUploadApi {
  static Future<MediaDTO?> uploadImage(
    Uint8List bytes, {
    required String fileName,
  }) async {
    final token = PreferencesServices.getToken();

    final uri = Uri.parse(AppStrings.mediaUpload).replace(
      queryParameters: {
        'type': AppStrings.mediaTypeProfilePhoto,
        'name': fileName,
      },
    );

    try {
      final request = http.MultipartRequest('POST', uri)
        ..headers[HttpHeaders.authorizationHeader] = 'Bearer ${token ?? ''}'
        ..headers[HttpHeaders.acceptHeader] = 'application/json'
        ..files.add(
          http.MultipartFile.fromBytes(
            AppStrings.mediaUploadFilePart,
            bytes,
            filename: fileName,
            contentType: MediaType('image', 'png'),
          ),
        );

      final response = await http.Response.fromStream(
        await request.send().timeout(const Duration(seconds: 60)),
      );

      _log.info('POST $uri -> ${response.statusCode} ${response.body}');

      if (response.statusCode != 200 && response.statusCode != 201) return null;

      return _parse(response.body);
    } catch (e) {
      _log.warning('Upload to $uri failed: $e');
      return null;
    }
  }

  /// `mobile` documents `{"<key>": ["<reference>"]}`; the sibling endpoints
  /// return `{"data": [MediaDTO]}` (react) or a flat string map
  /// (mobile/single). [_fromDynamic] walks all three so switching endpoints
  /// doesn't silently drop the avatar.
  static MediaDTO? _parse(String body) {
    if (body.isEmpty) return null;

    dynamic decoded;
    try {
      decoded = jsonDecode(body);
    } catch (_) {
      _log.warning('Upload response was not JSON: $body');
      return null;
    }

    final media = _fromDynamic(decoded);
    if (media == null) _log.warning('No media found in upload response: $body');

    return media;
  }

  static MediaDTO? _fromDynamic(dynamic value) {
    // `mobile` hands back bare reference strings rather than media objects.
    if (value is String) return value.isEmpty ? null : _reference(value);

    if (value is List) {
      for (final item in value) {
        final found = _fromDynamic(item);
        if (found != null) return found;
      }
      return null;
    }

    if (value is Map) {
      final data = value['data'];
      if (data != null) {
        final found = _fromDynamic(data);
        if (found != null) return found;
      }

      // A media object is anything carrying a usable reference.
      final hasReference =
          (value['src'] is String && (value['src'] as String).isNotEmpty) ||
          (value['url'] is String && (value['url'] as String).isNotEmpty);

      if (hasReference) {
        try {
          return MediaDTO.fromJson(Map<String, dynamic>.from(value));
        } catch (_) {
          return null;
        }
      }

      for (final candidate in value.values) {
        final found = _fromDynamic(candidate);
        if (found != null) return found;
      }
    }

    return null;
  }

  /// Wraps a bare reference string in a [MediaDTO]. `src` is what the profile
  /// endpoint wants back; the url fields are filled in too when the reference
  /// is already absolute, so the avatar can still be fetched from the network
  /// once the locally cached crop is gone.
  static MediaDTO _reference(String src) {
    final isAbsolute = src.startsWith('http');

    return MediaDTO(
      src: src,
      originalName: '',
      url: isAbsolute ? src : '',
      fileSizeStr: '',
      originalUrl: isAbsolute ? src : '',
      thumbUrl: '',
      fileSize: 0,
      extension: '',
    );
  }
}

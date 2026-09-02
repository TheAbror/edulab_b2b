import 'package:edulab_b2b/widget_imports.dart';

/// On-device copy of the user's avatar.
///
/// The cropped image is written to the documents directory and its path kept
/// in preferences, so the avatar renders instantly after a crop and survives a
/// restart even if the upload to the backend hasn't landed yet. It takes
/// priority over the server's `profile_photo` URL in [ProfileAvatarImage].
class ProfilePhotoStorage {
  /// Writes [bytes] to a fresh file and points preferences at it.
  ///
  /// The filename carries a timestamp because Flutter's image cache keys on
  /// path - reusing one path would keep showing the previous crop.
  static Future<File?> save(Uint8List bytes) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File(
        '${directory.path}/profile_photo_'
        '${DateTime.now().millisecondsSinceEpoch}.png',
      );
      await file.writeAsBytes(bytes, flush: true);

      await _deleteStoredFile();
      await PreferencesServices.saveProfilePhotoPath(file.path);

      return file;
    } catch (_) {
      return null;
    }
  }

  /// Drops the cached file and forgets the path.
  static Future<void> clear() async {
    await _deleteStoredFile();
    await PreferencesServices.saveProfilePhotoPath(null);
  }

  /// The cached avatar, or null if there isn't one. Synchronous so widgets can
  /// call it straight from `build`; the `existsSync` result is memoised per
  /// path so repeated builds don't stat the file every frame.
  static File? current() {
    final path = PreferencesServices.getProfilePhotoPath();

    if (path == null || path.isEmpty) {
      _checkedPath = null;
      _checkedFile = null;
      return null;
    }

    if (path == _checkedPath) return _checkedFile;

    final file = File(path);
    _checkedPath = path;
    _checkedFile = file.existsSync() ? file : null;

    return _checkedFile;
  }

  static String? _checkedPath;
  static File? _checkedFile;

  static Future<void> _deleteStoredFile() async {
    final path = PreferencesServices.getProfilePhotoPath();
    if (path == null || path.isEmpty) return;

    try {
      final file = File(path);
      if (await file.exists()) await file.delete();
    } catch (_) {
      // A stale file we can't remove is harmless - the path is dropped anyway.
    }
  }
}

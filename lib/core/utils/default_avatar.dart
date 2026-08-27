import 'package:edulab_b2b/widget_imports.dart';

final List<AssetGenImage> _defaultAvatars = Assets.images.avatars.values;

AssetGenImage defaultAvatarForUserId(int? userId) {
  final index = (userId ?? 0).abs() % _defaultAvatars.length;
  return _defaultAvatars[index];
}

/// Key used to mean "show initials instead of an illustration" in the
/// avatar-type picker and in [PreferencesServices.getSelectedAvatarKey].
const String initialsAvatarKey = 'initials';

/// The named default avatars a user can pick from in "Change avatar type",
/// in the order they should be listed. Keys are what gets persisted via
/// [PreferencesServices.saveSelectedAvatarKey].
final Map<String, AssetGenImage> namedDefaultAvatars = {
  'panda': Assets.images.avatars.panda,
  'meerkat': Assets.images.avatars.meerkat,
  'chicken': Assets.images.avatars.chicken,
  'bear': Assets.images.avatars.bear,
  'koala': Assets.images.avatars.koala,
  'sea_lion': Assets.images.avatars.seaLion,
  'penguin': Assets.images.avatars.penguin,
  'tiger': Assets.images.avatars.tiger,
  'lion': Assets.images.avatars.lion,
  'bee': Assets.images.avatars.bee,
  'parrot': Assets.images.avatars.parrot,
  'hippo': Assets.images.avatars.hippo,
};

String initialsFor(LocalStorageUserInfo? db) {
  final first = (db?.firstName ?? '').trim();
  final last = (db?.lastName ?? '').trim();
  final initials =
      '${first.isNotEmpty ? first[0] : ''}${last.isNotEmpty ? last[0] : ''}';
  return initials.isEmpty ? '?' : initials.toUpperCase();
}

bool hasUploadedPhoto(LocalStorageUserInfo? db) {
  final url = db?.profile_photo?.originalUrl;
  return db?.profile_photo != null && url != null && url.isNotEmpty;
}

/// Renders the user's avatar, honoring (in priority order): an uploaded
/// profile photo, a locally-picked default avatar type, then falling back
/// to the deterministic per-user default.
class ProfileAvatarImage extends StatelessWidget {
  final LocalStorageUserInfo? db;
  final double size;

  const ProfileAvatarImage({super.key, required this.db, required this.size});

  @override
  Widget build(BuildContext context) {
    final photoUrl = db?.profile_photo?.originalUrl;

    if (hasUploadedPhoto(db) && photoUrl != null) {
      return ClipOval(
        child: CachedNetworkImage(
          imageUrl: photoUrl,
          width: size,
          height: size,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            width: size,
            height: size,
            color: Colors.grey[200],
            child: Center(child: CircularProgressIndicator()),
          ),
          errorWidget: (context, url, error) => _fallback(context),
        ),
      );
    }

    return _fallback(context);
  }

  Widget _fallback(BuildContext context) {
    final selectedKey = PreferencesServices.getSelectedAvatarKey();

    if (selectedKey == initialsAvatarKey) {
      return Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.colors.neutralContainerDefault.withOpacity(0.1),
        ),
        child: Text(
          initialsFor(db),
          style: TextStyle(
            fontSize: size * 0.29,
            fontWeight: FontWeight.w500,
            color: context.colors.neutralOnContainer,
          ),
        ),
      );
    }

    final asset =
        namedDefaultAvatars[selectedKey] ?? defaultAvatarForUserId(db?.id);

    return ClipOval(
      child: asset.image(width: size, height: size, fit: BoxFit.cover),
    );
  }
}

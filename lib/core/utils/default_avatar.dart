import 'package:edulab_b2b/widget_imports.dart';

final List<AssetGenImage> _defaultAvatars = Assets.images.avatars.values;

AssetGenImage defaultAvatarForUserId(int? userId) {
  final index = (userId ?? 0).abs() % _defaultAvatars.length;
  return _defaultAvatars[index];
}

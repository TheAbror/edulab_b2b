import 'package:edulab_b2b/widget_imports.dart';

class EditProfileAvatarRow extends StatelessWidget {
  final LocalStorageUserInfo? db;

  /// Opens the gallery and applies whatever comes back.
  final VoidCallback onPickPhoto;
  final VoidCallback onRemove;
  final VoidCallback onAvatarTypeChanged;

  const EditProfileAvatarRow({
    super.key,
    required this.db,
    required this.onPickPhoto,
    required this.onRemove,
    required this.onAvatarTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final hasPhoto = hasUploadedPhoto(db);

    return Container(
      padding: EdgeInsets.only(
        left: 12.w,
        right: 20.w,
        top: 12.h,
        bottom: 12.h,
      ),
      decoration: BoxDecoration(
        color: context.colors.bgSurface1,
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Row(
        children: [
          ProfileAvatarImage(db: db, size: 56.w),
          SizedBox(width: 16.w),
          if (hasPhoto) ...[
            _pillButton(
              context,
              text: context.localizations.edit,
              onTap: onPickPhoto,
            ),
            SizedBox(width: 6.w),
            _pillButton(
              context,
              text: context.localizations.removeButton,
              isDestructive: true,
              onTap: onRemove,
            ),
          ] else
            _pillButton(
              context,
              text: context.localizations.upload,
              onTap: onPickPhoto,
            ),
          Spacer(),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => showEditProfilePhotoActionSheet(
              context,
              hasPhoto: hasPhoto,
              onPickPhoto: onPickPhoto,
              onRemove: onRemove,
              onAvatarTypeChanged: onAvatarTypeChanged,
            ),
            child: Container(
              width: 36.w,
              height: 36.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: context.colors.neutralContainerDefault.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 20.w,
                color: context.colors.neutralOnContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pillButton(
    BuildContext context, {
    required String text,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        height: 36.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isDestructive
              ? context.colors.errorContainerDefault.withOpacity(0.1)
              : context.colors.neutralContainerDefault.withOpacity(0.1),
          borderRadius: BorderRadius.circular(999.r),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
            color: isDestructive
                ? context.colors.errorOnContainer
                : context.colors.neutralOnContainer,
          ),
        ),
      ),
    );
  }
}

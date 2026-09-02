import 'package:edulab_b2b/widget_imports.dart';

Future<void> showEditProfilePhotoActionSheet(
  BuildContext context, {
  required bool hasPhoto,
  required VoidCallback onPickPhoto,
  required VoidCallback onRemove,
  required VoidCallback onAvatarTypeChanged,
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (sheetContext) {
      return SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.w, 20.h, 10.w, 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: context.colors.bgSurface1,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    _actionRow(
                      sheetContext,
                      // Same action either way; the label just reflects
                      // whether there's already a photo to replace.
                      text: hasPhoto
                          ? context.localizations.edit
                          : context.localizations.upload,
                      onTap: () {
                        Navigator.pop(sheetContext);
                        onPickPhoto();
                      },
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: context.colors.borderMuted.withOpacity(0.15),
                    ),
                    _actionRow(
                      sheetContext,
                      text: context.localizations.changeType,
                      onTap: () async {
                        Navigator.pop(sheetContext);
                        final changed = await showAvatarTypeSheet(
                          context,
                          selectedKey:
                              PreferencesServices.getSelectedAvatarKey(),
                        );
                        if (changed == true) onAvatarTypeChanged();
                      },
                    ),
                    if (hasPhoto) ...[
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: context.colors.borderMuted.withOpacity(0.15),
                      ),
                      _actionRow(
                        sheetContext,
                        text: context.localizations.removeButton,
                        isDestructive: true,
                        onTap: () {
                          Navigator.pop(sheetContext);
                          onRemove();
                        },
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => Navigator.pop(sheetContext),
                child: Container(
                  width: double.infinity,
                  height: 48.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: context.colors.bgSurface1,
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                  child: Text(
                    context.localizations.cancelButton,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.16,
                      color: context.colors.neutralOnContainer,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _actionRow(
  BuildContext context, {
  required String text,
  required VoidCallback onTap,
  bool isDestructive = false,
}) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: onTap,
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16.h),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: isDestructive
              ? context.colors.errorDefault
              : context.colors.fgDefault,
        ),
      ),
    ),
  );
}

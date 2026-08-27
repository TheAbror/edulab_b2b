import 'package:edulab_b2b/widget_imports.dart';

/// Shows the "Avatar type" picker. Persists the pick immediately via
/// [PreferencesServices.saveSelectedAvatarKey] and resolves to `true` if the
/// selection changed, so the caller knows to refresh what it's showing.
Future<bool> showAvatarTypeSheet(
  BuildContext context, {
  required String? selectedKey,
}) async {
  final result = await showModalBottomSheet<bool>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (sheetContext) {
      return _AvatarTypeSheet(selectedKey: selectedKey);
    },
  );

  return result ?? false;
}

class _AvatarTypeSheet extends StatelessWidget {
  final String? selectedKey;

  const _AvatarTypeSheet({required this.selectedKey});

  List<MapEntry<String, String>> _labeledOptions(BuildContext context) {
    final lang = context.localizations;
    return [
      MapEntry(initialsAvatarKey, lang.initials),
      MapEntry('panda', lang.avatarPanda),
      MapEntry('meerkat', lang.avatarMeerkat),
      MapEntry('chicken', lang.avatarChicken),
      MapEntry('bear', lang.avatarBear),
      MapEntry('koala', lang.avatarKoala),
      MapEntry('sea_lion', lang.avatarSeaLion),
      MapEntry('penguin', lang.avatarPenguin),
      MapEntry('tiger', lang.avatarTiger),
      MapEntry('lion', lang.avatarLion),
      MapEntry('bee', lang.avatarBee),
      MapEntry('parrot', lang.avatarParrot),
      MapEntry('hippo', lang.avatarHippo),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final options = _labeledOptions(context);

    return SafeArea(
      top: false,
      child: Container(
        constraints: BoxConstraints(maxHeight: 0.8.sh),
        decoration: BoxDecoration(
          color: context.colors.bgSurface1,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: context.colors.borderMuted.withOpacity(0.15),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.localizations.avatarType,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.16,
                      color: context.colors.fgDefault,
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 20.w,
                      height: 20.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: context.colors.neutralContainerDefault
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Assets.icons.homeTabIcons.close.svg(
                        colorFilter: ColorFilter.mode(
                          context.colors.fgDefault,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                shrinkWrap: true,
                children: [
                  for (final option in options)
                    _AvatarTypeRow(
                      avatarKey: option.key,
                      label: option.value,
                      isSelected: option.key == selectedKey,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AvatarTypeRow extends StatelessWidget {
  final String avatarKey;
  final String label;
  final bool isSelected;

  const _AvatarTypeRow({
    required this.avatarKey,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        await PreferencesServices.saveSelectedAvatarKey(avatarKey);
        if (context.mounted) Navigator.pop(context, true);
      },
      child: Container(
        padding: EdgeInsets.only(left: 8.w, right: 12.w, top: 6.h, bottom: 6.h),
        margin: EdgeInsets.only(bottom: 4.h),
        decoration: BoxDecoration(
          color: isSelected
              ? context.colors.accentContainerDefault.withOpacity(0.1)
              : null,
          borderRadius: BorderRadius.circular(999.r),
        ),
        child: Row(
          children: [
            _avatarPreview(context),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.07,
                  color: context.colors.fgDefault,
                ),
              ),
            ),
            Container(
              width: 22.w,
              height: 22.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
                border: isSelected
                    ? null
                    : Border.all(
                        color: context.colors.borderSoft.withOpacity(0.25),
                      ),
              ),
              child: isSelected
                  ? Icon(Icons.circle, size: 8.w, color: context.colors.float)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _avatarPreview(BuildContext context) {
    if (avatarKey == initialsAvatarKey) {
      return Container(
        width: 36.w,
        height: 36.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.colors.neutralContainerDefault.withOpacity(0.1),
        ),
        child: Text(
          'AB',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: context.colors.neutralOnContainer,
          ),
        ),
      );
    }

    final asset = namedDefaultAvatars[avatarKey];
    if (asset == null) return SizedBox(width: 36.w, height: 36.w);

    return ClipOval(
      child: asset.image(width: 36.w, height: 36.w, fit: BoxFit.cover),
    );
  }
}

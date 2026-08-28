import 'package:edulab_b2b/widget_imports.dart';

class EditProfileBiography extends StatefulWidget {
  final TextEditingController controller;

  const EditProfileBiography({super.key, required this.controller});

  @override
  State<EditProfileBiography> createState() => _EditProfileBiographyState();
}

class _EditProfileBiographyState extends State<EditProfileBiography> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  /// The keyboard animates in over ~250ms. Scrolling before it settles measures
  /// the old viewport, so wait it out and then lift the field above it.
  void _onFocusChange() {
    if (!_focusNode.hasFocus) return;

    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted || !_focusNode.hasFocus) return;

      Scrollable.ensureVisible(
        context,
        alignment: 0.5,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: EditProfileBoxDecoration(context),
      child: TextField(
        controller: widget.controller,
        focusNode: _focusNode,
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w400,
          color: context.colors.fgDefault,
        ),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.zero,
          hintText: context.localizations.aboutMe,
          hintStyle: TextStyle(color: context.colors.fgSoft),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}

BoxDecoration EditProfileBoxDecoration(BuildContext context) {
  return BoxDecoration(
    color: Theme.of(context).colorScheme.background,
    borderRadius: BorderRadius.circular(6.r),
    border: Border.all(
      color: context.colors.borderMuted.withOpacity(0.15),
      width: 1.w,
    ),
  );
}

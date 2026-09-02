import 'package:edulab_b2b/widget_imports.dart';

/// The floating "- + | Reset" pill that sits over the bottom of the crop stage.
class CropZoomControls extends StatelessWidget {
  final VoidCallback onZoomOut;
  final VoidCallback onZoomIn;
  final VoidCallback onReset;

  const CropZoomControls({
    super.key,
    required this.onZoomOut,
    required this.onZoomIn,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      decoration: BoxDecoration(
        color: context.colors.bgSurface1,
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _iconButton(context, Icons.remove_rounded, onZoomOut),
          SizedBox(width: 4.w),
          _iconButton(context, Icons.add_rounded, onZoomIn),
          SizedBox(width: 10.w),
          Container(
            width: 1,
            height: 20.h,
            color: context.colors.borderMuted.withOpacity(0.3),
          ),
          SizedBox(width: 10.w),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onReset,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              child: Text(
                context.localizations.reset,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: context.colors.fgDefault,
                ),
              ),
            ),
          ),
          SizedBox(width: 4.w),
        ],
      ),
    );
  }

  Widget _iconButton(BuildContext context, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: 32.w,
        height: 32.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: context.colors.neutralContainerDefault.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18.w, color: context.colors.fgDefault),
      ),
    );
  }
}

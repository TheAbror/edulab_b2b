import 'package:edulab_b2b/widget_imports.dart';

class AuthMethodSegmentControl extends StatelessWidget {
  final AuthMethod value;
  final ValueChanged<AuthMethod> onChanged;

  const AuthMethodSegmentControl({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: context.colors.neutralContainerDefault.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          _Segment(
            text: context.localizations.phone,
            isSelected: value == AuthMethod.phone,
            onTap: () => onChanged(AuthMethod.phone),
          ),
          _Segment(
            text: context.localizations.email,
            isSelected: value == AuthMethod.email,
            onTap: () => onChanged(AuthMethod.email),
          ),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _Segment({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          height: 28.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? context.colors.float : Colors.transparent,
            borderRadius: BorderRadius.circular(6.r),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 3,
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 2,
                    ),
                  ]
                : null,
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: context.colors.fgDefault,
              letterSpacing: -0.5,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:edulab_b2b/widget_imports.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final bool isFilled;
  final bool isDisabled;
  final VoidCallback onTap;

  const ActionButton({
    super.key,
    required this.text,
    this.isFilled = true,
    this.isDisabled = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: isFilled ? 14.h : 12.h),
            decoration: BoxDecoration(
              color: isDisabled
                  ? Theme.of(context).colorScheme.surfaceTint.withOpacity(0.1)
                  : isFilled
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(defaultRadius.r)),
              border: Border.all(
                color: isFilled
                    ? Colors.transparent
                    : context.colors.accentMuted,
                width: isFilled ? 0.w : 2.w,
              ),
            ),
            child: Center(
              child: state.blocProgress == BlocProgress.IS_LOADING
                  ? SizedBox(
                      width: 18.w,
                      height: 18.w,
                      child: CircularProgressIndicator(
                        color: context.colors.float,
                        strokeWidth: 2.w,
                      ),
                    )
                  : Text(
                      text,
                      style: TextStyle(
                        letterSpacing: -0.5,
                        fontSize: 16.sp,
                        color: isDisabled
                            ? Theme.of(
                                context,
                              ).colorScheme.surfaceTint.withOpacity(0.4)
                            : !isFilled
                            ? context.colors.accentOnContainer
                            : context.colors.float,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}

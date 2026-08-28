import 'package:edulab_b2b/widget_imports.dart';

class AuthIdentifierField extends StatelessWidget {
  final AuthMethod method;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final bool hasError;
  final ValueChanged<String> onChanged;

  const AuthIdentifierField({
    super.key,
    required this.method,
    required this.controller,
    required this.onChanged,
    this.focusNode,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    final isPhone = method == AuthMethod.phone;
    final borderColor = hasError
        ? context.colors.errorDefault
        : context.colors.borderMuted.withOpacity(0.15);
    final labelColor = hasError
        ? context.colors.errorDefault
        : context.colors.fgSoft;

    return Container(
      height: 48.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: context.colors.float,
        border: Border.all(color: borderColor, width: 1.w),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        children: [
          isPhone
              ? Assets.icons.main.call.svg(
                  height: 24.w,
                  width: 24.w,
                  colorFilter: ColorFilter.mode(
                    context.colors.fgDefault,
                    BlendMode.srcIn,
                  ),
                )
              : Assets.icons.main.sms.svg(
                  height: 24.w,
                  width: 24.w,
                  colorFilter: ColorFilter.mode(
                    context.colors.fgDefault,
                    BlendMode.srcIn,
                  ),
                ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isPhone
                      ? context.localizations.phone
                      : context.localizations.email,
                  style: TextStyle(fontSize: 12.sp, color: labelColor),
                ),
                TextField(
                  controller: controller,
                  focusNode: focusNode,
                  onChanged: onChanged,
                  keyboardType: isPhone
                      ? TextInputType.phone
                      : TextInputType.emailAddress,
                  inputFormatters: isPhone
                      ? const [PhoneInputFormatter()]
                      : null,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: context.colors.fgDefault,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    isCollapsed: true,
                    border: InputBorder.none,
                    hintText: isPhone
                        ? '+998 00 000 00 00'
                        : 'email@example.com',
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      color: context.colors.fgMuted,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:edulab_b2b/widget_imports.dart';

InputDecoration authFieldDecoration(
  BuildContext context,
  String hintText, {
  bool suffixicon = false,
}) {
  return InputDecoration(
    border: InputBorder.none,
    contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.w),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: context.colors.borderMuted.withOpacity(0.2),
        width: 2.w,
      ),
      borderRadius: BorderRadius.circular(defaultRadius.r),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.primary,
        width: 2.w,
      ),
      borderRadius: BorderRadius.circular(defaultRadius.r),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2.w),
      borderRadius: BorderRadius.circular(defaultRadius.r),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2.w),
      borderRadius: BorderRadius.circular(defaultRadius.r),
    ),
    fillColor: Theme.of(context).colorScheme.surfaceTint,
    hintText: hintText,
    suffixIcon: suffixicon
        ? BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return InkWell(
                onTap: () {
                  context.read<AuthBloc>().isPasswordHidden();
                },
                child: state.isPasswordHidden
                    ? Icon(
                        Icons.visibility_outlined,
                        size: 20.sp,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : Icon(
                        Icons.visibility_off_outlined,
                        size: 20.sp,
                        color: Theme.of(context).colorScheme.primary,
                      ),
              );
            },
          )
        : SizedBox(),
  );
}

import 'package:leti_mobile/widget_imports.dart';

class TabText extends StatelessWidget {
  final String text;

  const TabText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

import 'package:edulab_b2b/widget_imports.dart';

class TabText extends StatelessWidget {
  final String text;

  const TabText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AppText.paragraph2(
      text,
      color: context.colors.fgDefault,
      maxLines: 1,
    );
  }
}

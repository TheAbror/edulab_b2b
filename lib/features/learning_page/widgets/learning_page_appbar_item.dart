import 'package:edulab_b2b/widget_imports.dart';

class LearningPageAppBarItem extends StatelessWidget {
  final double? height;
  final String text;

  const LearningPageAppBarItem({super.key, required this.text, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 28.h,
      alignment: Alignment.center,
      child: AppText.paragraph1(
        text.length > 15 ? '${text.substring(0, 15)}...' : text,
      ),
    );
  }
}

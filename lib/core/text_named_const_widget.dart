// * Create custom widget with named constructors

import 'package:leti_mobile/widget_imports.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Color? color;
  final int? maxLines;

  const AppText(
    this.text, {
    this.style = const TextStyle(),
    this.color,
    this.maxLines,
    super.key,
  });

  AppText.title1(this.text, {this.color, this.maxLines, super.key})
    : style = TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w500,
        color: color,
        letterSpacing: -0.8,
      );

  AppText.title2(this.text, {this.color, this.maxLines, super.key})
    : style = TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: color,
      );

  AppText.title3(this.text, {this.color, this.maxLines, super.key})
    : style = TextStyle(
        fontSize: 17.sp,
        fontWeight: FontWeight.w600,
        color: color,
      );

  AppText.headline1(this.text, {this.color, this.maxLines, super.key})
    : style = TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: color,
      );

  AppText.headline2(this.text, {this.color, this.maxLines, super.key})
    : style = TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
        color: color,
      );

  AppText.text(this.text, {this.color, this.maxLines, super.key})
    : style = TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: color,
      );

  AppText.paragraph1(this.text, {this.color, this.maxLines, super.key})
    : style = TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
        color: color,
      );

  AppText.paragraph2(this.text, {this.color, this.maxLines, super.key})
    : style = TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: color,
      );

  AppText.subHeading(this.text, {this.color, this.maxLines, super.key})
    : style = TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: color,
      );

  AppText.footNote(this.text, {this.color, this.maxLines, super.key})
    : style = TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
        color: color,
      );

  AppText.footNoteCaps(this.text, {this.color, this.maxLines, super.key})
    : style = TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
        color: color,
      );

  AppText.caption1(this.text, {this.color, this.maxLines, super.key})
    : style = TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: color,
      );

  AppText.caption1Caps(this.text, {this.color, this.maxLines, super.key})
    : style = TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: color,
      );

  AppText.caption2(this.text, {this.color, this.maxLines, super.key})
    : style = TextStyle(
        fontSize: 11.sp,
        fontWeight: FontWeight.w400,
        color: color,
      );

  AppText.caption2Caps(this.text, {this.color, this.maxLines, super.key})
    : style = TextStyle(
        fontSize: 11.sp,
        fontWeight: FontWeight.w500,
        color: color,
      );

  AppText.caption3(this.text, {this.color, this.maxLines, super.key})
    : style = TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
        color: color,
      );

  AppText.caption3Caps(this.text, {this.color, this.maxLines, super.key})
    : style = TextStyle(
        fontSize: 11.sp,
        fontWeight: FontWeight.w500,
        color: color,
      );

  AppText.baseText(this.text, {this.color, this.maxLines, super.key})
    : style = TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: color,
      );

  AppText.baseAccentTitle(this.text, {this.color, this.maxLines, super.key})
    : style = TextStyle(
        fontSize: 36.sp,
        fontWeight: FontWeight.w500,
        color: color,
      );

  AppText.baseAccentTitle2(this.text, {this.color, this.maxLines, super.key})
    : style = TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w500,
        color: color,
      );

  AppText.customTitle2Medium(this.text, {this.color, this.maxLines, super.key})
    : style = TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
        color: color,
      );

  AppText.headline1Light(this.text, {this.color, this.maxLines, super.key})
    : style = TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: color,
      );

  AppText.paragraph1Medium(this.text, {this.color, this.maxLines, super.key})
    : style = TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
        color: color,
      );

  AppText.subheadSemiBold(this.text, {this.color, this.maxLines, super.key})
    : style = TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: color,
      );

  AppText.footnoteBold(this.text, {this.color, this.maxLines, super.key})
    : style = TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
        color: color,
      );

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}

// AppText.paragraph1(
//   "This is a paragraph",
//   color: Theme.of(context).colorScheme.tertiaryFixed, // Optional
// );

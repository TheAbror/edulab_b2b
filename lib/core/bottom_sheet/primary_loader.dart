import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryLoader extends StatelessWidget {
  final bool withCentering;
  final EdgeInsets padding;
  final double size;
  final double strokeWidth;

  const PrimaryLoader({
    super.key,
    this.padding = EdgeInsets.zero,
    this.withCentering = true,
    this.size = 36,
    this.strokeWidth = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    if (withCentering) {
      return Center(
        child: Container(
          width: size,
          height: size,
          padding: padding,
          child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
              strokeWidth: strokeWidth),
        ),
      );
    } else {
      return Container(
        width: size,
        height: size,
        padding: padding,
        child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
            strokeWidth: strokeWidth),
      );
    }
  }
}

class PrimaryBottomSheetLoader extends StatelessWidget {
  const PrimaryBottomSheetLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 80.h),
        child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}

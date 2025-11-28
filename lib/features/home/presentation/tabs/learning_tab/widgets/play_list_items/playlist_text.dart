import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlayListText extends StatelessWidget {
  const PlayListText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Playlist',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15.sp,
      ),
    );
  }
}

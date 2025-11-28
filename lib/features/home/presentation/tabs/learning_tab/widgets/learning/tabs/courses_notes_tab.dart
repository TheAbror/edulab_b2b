import 'package:flutter/material.dart';

class CoursesNotesTab extends StatelessWidget {
  const CoursesNotesTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Text('Notes\n' * 100),
    );
  }
}

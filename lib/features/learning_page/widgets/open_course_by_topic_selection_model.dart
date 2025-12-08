import 'package:leti_mobile/widget_imports.dart';

class OpenCourseByTopicSelectionModel {
  final int courseID;
  final CurrentlyActive? ids;

  OpenCourseByTopicSelectionModel({
    required this.courseID,
    this.ids,
  });
}

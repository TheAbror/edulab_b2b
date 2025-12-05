import 'package:json_annotation/json_annotation.dart';

part 'course_progress_model.g.dart';

// {
//   "id": 21991,
//   "course_completed": false,
//   "chapter_completed": false,
//   "topic_completed": false,
//   "current_course_progress": 2,
//   "current_chapter_progress": 21,
//   "current_topic_progress": 25,
//   "next_chapter_id": 6738,
//   "next_topic_id": 6777,
//   "next_step_id": 6994
// }

@JsonSerializable(includeIfNull: true)
class CourseProgressModel {
  @JsonKey(defaultValue: 0)
  final int id;

  @JsonKey(name: "course_completed", defaultValue: false)
  final bool courseCompleted;

  @JsonKey(name: "chapter_completed", defaultValue: false)
  final bool chapterCompleted;

  @JsonKey(name: "topic_completed", defaultValue: false)
  final bool topicCompleted;

  @JsonKey(name: "current_course_progress", defaultValue: 0)
  final int currentCourseProgress;

  @JsonKey(name: "current_chapter_progress", defaultValue: 0)
  final int currentChapterProgress;

  @JsonKey(name: "current_topic_progress", defaultValue: 0)
  final int currentTopicProgress;

  @JsonKey(name: "next_chapter_id", defaultValue: 0)
  final int nextChapterId;

  @JsonKey(name: "next_topic_id", defaultValue: 0)
  final int nextTopicId;

  @JsonKey(name: "next_step_id", defaultValue: 0)
  final int nextStepId;

  CourseProgressModel({
    required this.id,
    required this.courseCompleted,
    required this.chapterCompleted,
    required this.topicCompleted,
    required this.currentCourseProgress,
    required this.currentChapterProgress,
    required this.currentTopicProgress,
    required this.nextChapterId,
    required this.nextTopicId,
    required this.nextStepId,
  });

  factory CourseProgressModel.initial() {
    return CourseProgressModel(
      id: 0,
      courseCompleted: false,
      chapterCompleted: false,
      topicCompleted: false,
      currentChapterProgress: 0,
      currentCourseProgress: 0,
      currentTopicProgress: 0,
      nextChapterId: 0,
      nextStepId: 0,
      nextTopicId: 0,
    );
  }

  factory CourseProgressModel.fromJson(Map<String, dynamic> json) =>
      _$CourseProgressModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseProgressModelToJson(this);
}

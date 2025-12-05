// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_progress_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseProgressModel _$CourseProgressModelFromJson(Map<String, dynamic> json) =>
    CourseProgressModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      courseCompleted: json['course_completed'] as bool? ?? false,
      chapterCompleted: json['chapter_completed'] as bool? ?? false,
      topicCompleted: json['topic_completed'] as bool? ?? false,
      currentCourseProgress:
          (json['current_course_progress'] as num?)?.toInt() ?? 0,
      currentChapterProgress:
          (json['current_chapter_progress'] as num?)?.toInt() ?? 0,
      currentTopicProgress:
          (json['current_topic_progress'] as num?)?.toInt() ?? 0,
      nextChapterId: (json['next_chapter_id'] as num?)?.toInt() ?? 0,
      nextTopicId: (json['next_topic_id'] as num?)?.toInt() ?? 0,
      nextStepId: (json['next_step_id'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CourseProgressModelToJson(
  CourseProgressModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'course_completed': instance.courseCompleted,
  'chapter_completed': instance.chapterCompleted,
  'topic_completed': instance.topicCompleted,
  'current_course_progress': instance.currentCourseProgress,
  'current_chapter_progress': instance.currentChapterProgress,
  'current_topic_progress': instance.currentTopicProgress,
  'next_chapter_id': instance.nextChapterId,
  'next_topic_id': instance.nextTopicId,
  'next_step_id': instance.nextStepId,
};

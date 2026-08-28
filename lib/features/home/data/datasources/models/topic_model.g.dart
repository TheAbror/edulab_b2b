// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicModel _$TopicModelFromJson(Map<String, dynamic> json) => TopicModel(
  id: (json['id'] as num?)?.toInt() ?? 0,
  title: json['title'] as String? ?? '',
  description: json['description'] as String? ?? '',
  priority: (json['priority'] as num?)?.toInt() ?? 0,
  courseId: (json['course_id'] as num?)?.toInt(),
  chapterId: (json['chapter_id'] as num?)?.toInt(),
  status: json['status'] as String? ?? '',
  stepsInfo: json['steps_info'] as Map<String, dynamic>?,
  resources:
      (json['resources'] as List<dynamic>?)
          ?.map((e) => MediaDTO.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  steps:
      (json['steps'] as List<dynamic>?)
          ?.map((e) => StepModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$TopicModelToJson(TopicModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'priority': instance.priority,
      'course_id': instance.courseId,
      'chapter_id': instance.chapterId,
      'status': instance.status,
      'steps_info': instance.stepsInfo,
      'resources': instance.resources,
      'steps': instance.steps,
    };

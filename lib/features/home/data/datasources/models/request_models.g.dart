// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompleteStepRequest _$CompleteStepRequestFromJson(Map<String, dynamic> json) =>
    CompleteStepRequest(
      chapterID: (json['chapter_id'] as num?)?.toInt() ?? 0,
      topicID: (json['topic_id'] as num?)?.toInt() ?? 0,
      stepID: (json['step_id'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CompleteStepRequestToJson(
  CompleteStepRequest instance,
) => <String, dynamic>{
  'chapter_id': instance.chapterID,
  'topic_id': instance.topicID,
  'step_id': instance.stepID,
};

EnrollmentRequest _$EnrollmentRequestFromJson(Map<String, dynamic> json) =>
    EnrollmentRequest(courseID: (json['course_id'] as num?)?.toInt() ?? 0);

Map<String, dynamic> _$EnrollmentRequestToJson(EnrollmentRequest instance) =>
    <String, dynamic>{'course_id': instance.courseID};

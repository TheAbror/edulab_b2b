import 'package:json_annotation/json_annotation.dart';

part 'request_models.g.dart';

@JsonSerializable()
class CompleteStepRequest {
  @JsonKey(defaultValue: 0, name: 'chapter_id')
  final int chapterID;
  @JsonKey(defaultValue: 0, name: 'topic_id')
  final int topicID;
  @JsonKey(defaultValue: 0, name: 'step_id')
  final int stepID;

  CompleteStepRequest({
    required this.chapterID,
    required this.topicID,
    required this.stepID,
  });

  factory CompleteStepRequest.fromJson(Map<String, dynamic> json) =>
      _$CompleteStepRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CompleteStepRequestToJson(this);
}

@JsonSerializable(includeIfNull: true)
class EnrollmentRequest {
  @JsonKey(name: 'course_id', defaultValue: 0)
  final int courseID;

  EnrollmentRequest({required this.courseID});

  factory EnrollmentRequest.fromJson(Map<String, dynamic> json) =>
      _$EnrollmentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$EnrollmentRequestToJson(this);
}

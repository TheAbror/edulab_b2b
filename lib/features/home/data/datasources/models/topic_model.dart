import 'package:json_annotation/json_annotation.dart';
import 'package:leti_mobile/features/home/data/datasources/models/step_model.dart';

part 'topic_model.g.dart';

@JsonSerializable(includeIfNull: true)
class TopicModel {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(defaultValue: '')
  final String title;
  @JsonKey(defaultValue: '')
  final String? description;
  @JsonKey(defaultValue: 0)
  final int priority;
  @JsonKey(name: 'course_id')
  final int? courseId;
  @JsonKey(name: 'chapter_id')
  final int? chapterId;
  @JsonKey(defaultValue: '')
  final String status;
  @JsonKey(name: 'steps_info')
  final Map<String, dynamic>? stepsInfo;
  @JsonKey(defaultValue: [])
  final List<StepModel> steps;

  TopicModel({
    required this.id,
    required this.title,
    this.description,
    required this.priority,
    this.courseId,
    this.chapterId,
    required this.status,
    this.stepsInfo,
    required this.steps,
  });

  factory TopicModel.fromJson(Map<String, dynamic> json) =>
      _$TopicModelFromJson(json);
  Map<String, dynamic> toJson() => _$TopicModelToJson(this);
}

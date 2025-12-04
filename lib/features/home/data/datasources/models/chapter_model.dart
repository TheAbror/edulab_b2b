import 'package:json_annotation/json_annotation.dart';
import 'package:leti_mobile/features/home/data/datasources/models/topic_model.dart';

part 'chapter_model.g.dart';

@JsonSerializable(includeIfNull: true)
class ChapterModel {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(defaultValue: '')
  final String title;
  @JsonKey(defaultValue: '')
  final String description;
  @JsonKey(defaultValue: 0)
  final int priority;
  @JsonKey(defaultValue: [])
  final List<TopicModel> topics;

  ChapterModel({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.topics,
  });

  factory ChapterModel.fromJson(Map<String, dynamic> json) =>
      _$ChapterModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChapterModelToJson(this);
}

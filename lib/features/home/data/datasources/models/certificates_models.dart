import 'package:json_annotation/json_annotation.dart';
import 'package:edulab_b2b/widget_imports.dart';

part 'certificates_models.g.dart';

@JsonSerializable(includeIfNull: true)
class CertificateByTopicIdModel {
  @JsonKey(defaultValue: '')
  String title;
  MediaDTO file;

  CertificateByTopicIdModel({required this.title, required this.file});

  factory CertificateByTopicIdModel.fromJson(Map<String, dynamic> json) =>
      _$CertificateByTopicIdModelFromJson(json);

  Map<String, dynamic> toJson() => _$CertificateByTopicIdModelToJson(this);
}

//! Get all topics in order to get content by their ids
@JsonSerializable(includeIfNull: true)
class AllTopicsResponse {
  @JsonKey(defaultValue: 0)
  final int total_elements;
  @JsonKey(defaultValue: [])
  List<AllTopicsContentResponse> content;

  AllTopicsResponse({required this.total_elements, required this.content});

  factory AllTopicsResponse.fromJson(Map<String, dynamic> json) =>
      _$AllTopicsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AllTopicsResponseToJson(this);
}

@JsonSerializable(includeIfNull: true)
class AllTopicsContentResponse {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(defaultValue: '')
  final String name;

  AllTopicsContentResponse({required this.id, required this.name});

  factory AllTopicsContentResponse.fromJson(Map<String, dynamic> json) =>
      _$AllTopicsContentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AllTopicsContentResponseToJson(this);
}

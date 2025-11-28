// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';

part 'home_models.g.dart';

@JsonSerializable(includeIfNull: true)
class TeacherModel {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(defaultValue: '')
  final String firstname;
  @JsonKey(defaultValue: '')
  final String lastname;
  @JsonKey(defaultValue: '')
  final String job_title;
  @JsonKey(defaultValue: '')
  final String about_me;
  @JsonKey(defaultValue: 0)
  final double average_rating;
  @JsonKey(defaultValue: 0)
  final int courses_number;
  @JsonKey(defaultValue: 0)
  final int total_reviews_number;
  @JsonKey(defaultValue: 0)
  final int total_students_number;
  @JsonKey(defaultValue: [])
  final List<String> roles;
  TeacherProfilePictureModel profile_picture;

  TeacherModel({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.job_title,
    required this.about_me,
    required this.average_rating,
    required this.courses_number,
    required this.total_reviews_number,
    required this.total_students_number,
    required this.roles,
    required this.profile_picture,
  });

  factory TeacherModel.fromJson(Map<String, dynamic> json) =>
      _$TeacherModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeacherModelToJson(this);
}

@JsonSerializable(includeIfNull: true)
class TeacherProfilePictureModel {
  @JsonKey(name: 'extension', defaultValue: '')
  final String pic_extension;
  @JsonKey(defaultValue: 0)
  final int file_size;
  @JsonKey(defaultValue: '')
  final String original_name;
  @JsonKey(defaultValue: '')
  final String original_url;
  @JsonKey(defaultValue: '')
  final String src;
  @JsonKey(defaultValue: '')
  final String thumb_url;
  @JsonKey(defaultValue: '')
  final String url;

  TeacherProfilePictureModel({
    required this.pic_extension,
    required this.file_size,
    required this.original_name,
    required this.original_url,
    required this.src,
    required this.thumb_url,
    required this.url,
  });

  factory TeacherProfilePictureModel.fromJson(Map<String, dynamic> json) =>
      _$TeacherProfilePictureModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeacherProfilePictureModelToJson(this);
}

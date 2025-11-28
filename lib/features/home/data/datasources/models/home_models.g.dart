// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeacherModel _$TeacherModelFromJson(Map<String, dynamic> json) => TeacherModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      firstname: json['firstname'] as String? ?? '',
      lastname: json['lastname'] as String? ?? '',
      job_title: json['job_title'] as String? ?? '',
      about_me: json['about_me'] as String? ?? '',
      average_rating: (json['average_rating'] as num?)?.toDouble() ?? 0,
      courses_number: (json['courses_number'] as num?)?.toInt() ?? 0,
      total_reviews_number:
          (json['total_reviews_number'] as num?)?.toInt() ?? 0,
      total_students_number:
          (json['total_students_number'] as num?)?.toInt() ?? 0,
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      profile_picture: TeacherProfilePictureModel.fromJson(
          json['profile_picture'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TeacherModelToJson(TeacherModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'job_title': instance.job_title,
      'about_me': instance.about_me,
      'average_rating': instance.average_rating,
      'courses_number': instance.courses_number,
      'total_reviews_number': instance.total_reviews_number,
      'total_students_number': instance.total_students_number,
      'roles': instance.roles,
      'profile_picture': instance.profile_picture,
    };

TeacherProfilePictureModel _$TeacherProfilePictureModelFromJson(
        Map<String, dynamic> json) =>
    TeacherProfilePictureModel(
      pic_extension: json['extension'] as String? ?? '',
      file_size: (json['file_size'] as num?)?.toInt() ?? 0,
      original_name: json['original_name'] as String? ?? '',
      original_url: json['original_url'] as String? ?? '',
      src: json['src'] as String? ?? '',
      thumb_url: json['thumb_url'] as String? ?? '',
      url: json['url'] as String? ?? '',
    );

Map<String, dynamic> _$TeacherProfilePictureModelToJson(
        TeacherProfilePictureModel instance) =>
    <String, dynamic>{
      'extension': instance.pic_extension,
      'file_size': instance.file_size,
      'original_name': instance.original_name,
      'original_url': instance.original_url,
      'src': instance.src,
      'thumb_url': instance.thumb_url,
      'url': instance.url,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_enrollment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseEnrollmentResponse _$CourseEnrollmentResponseFromJson(
  Map<String, dynamic> json,
) => CourseEnrollmentResponse(
  id: (json['id'] as num?)?.toInt() ?? 0,
  status: json['status'] as String? ?? '',
);

Map<String, dynamic> _$CourseEnrollmentResponseToJson(
  CourseEnrollmentResponse instance,
) => <String, dynamic>{'id': instance.id, 'status': instance.status};

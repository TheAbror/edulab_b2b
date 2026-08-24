import 'package:json_annotation/json_annotation.dart';

part 'course_enrollment_response.g.dart';

@JsonSerializable(includeIfNull: true)
class CourseEnrollmentResponse {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(defaultValue: '')
  final String status;
  @JsonKey(defaultValue: '', name: 'manager_status')
  final String? managerStatus;

  const CourseEnrollmentResponse({
    required this.id,
    required this.status,
    required this.managerStatus,
  });

  factory CourseEnrollmentResponse.initial() {
    return CourseEnrollmentResponse(id: 0, status: '', managerStatus: '');
  }

  factory CourseEnrollmentResponse.fromJson(Map<String, dynamic> json) =>
      _$CourseEnrollmentResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CourseEnrollmentResponseToJson(this);
}

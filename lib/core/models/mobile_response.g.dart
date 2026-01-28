// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MobileResponse _$MobileResponseFromJson(Map<String, dynamic> json) =>
    MobileResponse(isSuccess: json['deleted'] as bool);

Map<String, dynamic> _$MobileResponseToJson(MobileResponse instance) =>
    <String, dynamic>{'deleted': instance.isSuccess};

CheckEnrollmentResponse _$CheckEnrollmentResponseFromJson(
  Map<String, dynamic> json,
) => CheckEnrollmentResponse(status: json['status'] as String? ?? '');

Map<String, dynamic> _$CheckEnrollmentResponseToJson(
  CheckEnrollmentResponse instance,
) => <String, dynamic>{'status': instance.status};

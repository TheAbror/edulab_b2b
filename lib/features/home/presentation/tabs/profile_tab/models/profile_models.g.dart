// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileUpdateRequest _$ProfileUpdateRequestFromJson(
  Map<String, dynamic> json,
) => ProfileUpdateRequest(
  aboutMe: json['about_me'] as String?,
  profilePhoto: json['profile_photo'] as String?,
);

Map<String, dynamic> _$ProfileUpdateRequestToJson(
  ProfileUpdateRequest instance,
) => <String, dynamic>{
  'about_me': instance.aboutMe,
  'profile_photo': instance.profilePhoto,
};

ProfileResponse _$ProfileResponseFromJson(Map<String, dynamic> json) =>
    ProfileResponse(
      aboutMe: json['about_me'] as String? ?? '',
      profilePhoto: json['profile_photo'] == null
          ? null
          : MediaDTO.fromJson(json['profile_photo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileResponseToJson(ProfileResponse instance) =>
    <String, dynamic>{
      'about_me': instance.aboutMe,
      'profile_photo': instance.profilePhoto,
    };

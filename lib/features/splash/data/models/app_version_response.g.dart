// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_version_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppVersionResponse _$AppVersionResponseFromJson(Map<String, dynamic> json) =>
    AppVersionResponse(
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      showMaintanance: json['show_maintanance'] as bool? ?? false,
      iosMinVersion: (json['ios_min_version'] as num?)?.toInt() ?? 1,
      iosLatestVersion: (json['ios_latest_version'] as num?)?.toInt() ?? 1,
      androidMinVersion: (json['android_min_version'] as num?)?.toInt() ?? 1,
      androidLatestVersion:
          (json['android_latest_version'] as num?)?.toInt() ?? 1,
      iosStoreUrl: json['ios_store_url'] as String? ?? '',
      androidStoreUrl: json['android_store_url'] as String? ?? '',
    );

Map<String, dynamic> _$AppVersionResponseToJson(AppVersionResponse instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'show_maintanance': instance.showMaintanance,
      'ios_min_version': instance.iosMinVersion,
      'ios_latest_version': instance.iosLatestVersion,
      'android_min_version': instance.androidMinVersion,
      'android_latest_version': instance.androidLatestVersion,
      'ios_store_url': instance.iosStoreUrl,
      'android_store_url': instance.androidStoreUrl,
    };

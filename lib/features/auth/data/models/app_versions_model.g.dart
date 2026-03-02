// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_versions_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppVersionsModel _$AppVersionsModelFromJson(Map<String, dynamic> json) =>
    AppVersionsModel(
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      showMaintenance: json['show_maintenance'] as bool? ?? false,
      iosMinVersion: (json['ios_min_version'] as num?)?.toInt() ?? 1,
      iosLatestVersion: (json['ios_latest_version'] as num?)?.toInt() ?? 1,
      androidMinVersion: (json['android_min_version'] as num?)?.toInt() ?? 1,
      androidLatestVersion:
          (json['android_latest_version'] as num?)?.toInt() ?? 1,
      iosStoreUrl: json['ios_store_url'] as String? ?? '',
      androidStoreUrl: json['android_store_url'] as String? ?? '',
    );

Map<String, dynamic> _$AppVersionsModelToJson(AppVersionsModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'show_maintenance': instance.showMaintenance,
      'ios_min_version': instance.iosMinVersion,
      'ios_latest_version': instance.iosLatestVersion,
      'android_min_version': instance.androidMinVersion,
      'android_latest_version': instance.androidLatestVersion,
      'ios_store_url': instance.iosStoreUrl,
      'android_store_url': instance.androidStoreUrl,
    };

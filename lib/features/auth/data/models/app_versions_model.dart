import 'package:json_annotation/json_annotation.dart';

part 'app_versions_model.g.dart';

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class AppVersionsModel {
  @JsonKey(defaultValue: '')
  final String title;
  @JsonKey(defaultValue: '')
  final String description;
  @JsonKey(name: 'show_maintenance', defaultValue: false)
  final bool showMaintenance;
  @JsonKey(name: 'ios_min_version', defaultValue: 1)
  final int iosMinVersion;
  @JsonKey(name: 'ios_latest_version', defaultValue: 1)
  final int iosLatestVersion;
  @JsonKey(name: 'android_min_version', defaultValue: 1)
  final int androidMinVersion;
  @JsonKey(name: 'android_latest_version', defaultValue: 1)
  final int androidLatestVersion;
  @JsonKey(name: 'ios_store_url', defaultValue: '')
  final String iosStoreUrl;
  @JsonKey(name: 'android_store_url', defaultValue: '')
  final String androidStoreUrl;

  AppVersionsModel({
    required this.title,
    required this.description,
    required this.showMaintenance,
    required this.iosMinVersion,
    required this.iosLatestVersion,
    required this.androidMinVersion,
    required this.androidLatestVersion,
    required this.iosStoreUrl,
    required this.androidStoreUrl,
  });

  factory AppVersionsModel.initial() {
    return AppVersionsModel(
      title: '',
      description: '',
      showMaintenance: false,
      iosMinVersion: 1,
      iosLatestVersion: 1,
      androidMinVersion: 1,
      androidLatestVersion: 1,
      iosStoreUrl: '',
      androidStoreUrl: '',
    );
  }

  factory AppVersionsModel.fromJson(Map<String, dynamic> json) =>
      _$AppVersionsModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppVersionsModelToJson(this);
}

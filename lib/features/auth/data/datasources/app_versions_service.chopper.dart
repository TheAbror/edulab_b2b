// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'app_versions_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$AppVersionsService extends AppVersionsService {
  _$AppVersionsService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = AppVersionsService;

  @override
  Future<Response<AppVersionsModel>> getAppVersions() {
    final Uri $url = Uri.parse(
      'https://2785-213-230-79-129.ngrok-free.app/edulab/api/v1/core/mobile/settings/versions',
    );
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<AppVersionsModel, AppVersionsModel>($request);
  }
}

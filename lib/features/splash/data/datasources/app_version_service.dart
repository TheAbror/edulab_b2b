import 'package:chopper/chopper.dart';
import 'package:edulab_b2b/widget_imports.dart';

part 'app_version_service.chopper.dart';

@ChopperApi(baseUrl: AppStrings.baseLive)
abstract class AppVersionService extends ChopperService {
  static AppVersionService create([ChopperClient? client]) =>
      _$AppVersionService(client ?? ChopperClient());

  // @Get(path: AppStrings.appVersions)
  // Future<Response<AppVersionResponse>> getAppVersions();
}

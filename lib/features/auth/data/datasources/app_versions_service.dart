import 'package:chopper/chopper.dart';
import 'package:edulab_b2b/widget_imports.dart';

part 'app_versions_service.chopper.dart';

@ChopperApi(baseUrl: AppStrings.baseLive)
abstract class AppVersionsService extends ChopperService {
  static AppVersionsService create([ChopperClient? client]) =>
      _$AppVersionsService(client ?? ChopperClient());

  @Get(path: AppStrings.appVersions)
  Future<Response<AppVersionsModel>> getAppVersions();
}

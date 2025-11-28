import 'package:chopper/chopper.dart';
import 'package:leti_mobile/widget_imports.dart';

part 'home_services.chopper.dart';

@ChopperApi(baseUrl: AppStrings.baseLive)
abstract class HomeServices extends ChopperService {
  static HomeServices create([ChopperClient? client]) =>
      _$HomeServices(client ?? ChopperClient());

  @Get(path: AppStrings.teacher)
  Future<Response<List<TeacherModel>>> getTeachersList();

  @Get(path: '${AppStrings.teacher}/{id}')
  Future<Response<TeacherModel>> getTeacherById(@Path('id') int id);
}

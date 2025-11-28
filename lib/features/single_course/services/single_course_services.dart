import 'package:chopper/chopper.dart';
import 'package:leti_mobile/widget_imports.dart';

part 'single_course_services.chopper.dart';

@ChopperApi(baseUrl: AppStrings.baseLive)
abstract class SingleCourseServices extends ChopperService {
  static SingleCourseServices create([ChopperClient? client]) =>
      _$SingleCourseServices(client ?? ChopperClient());

  @Get(path: '${AppStrings.course}/{id}')
  Future<Response<SingleCourseInfo>> getSingleCourseByItsId(@Path('id') int id);

  @Get(path: '${AppStrings.learningWithID}/{id}')
  Future<Response<SingleCourseInfo>> resumeCourseById(@Path('id') int id);

  @Post(path: AppStrings.addToFavorite)
  Future<Response<MobileResponse>> postCourseAsFavorite(
    @Body() MakeCourseFavoriteRequest body,
  );
}

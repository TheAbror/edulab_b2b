import 'package:chopper/chopper.dart';
import 'package:leti_mobile/widget_imports.dart';

part 'courses_services.chopper.dart';

@ChopperApi(baseUrl: AppStrings.baseLive)
abstract class CourseServices extends ChopperService {
  static CourseServices create([ChopperClient? client]) =>
      _$CourseServices(client ?? ChopperClient());

  @Get(path: '${AppStrings.course}/')
  Future<Response<HomeCoursesResponse>> getAllCourses();

  @Get(path: AppStrings.currentCourseAsUnauthorized)
  Future<Response<List<CourseShortInfo>>> getAllCoursesAsUnauthorized();

  // @Get(path: AppStrings.currentCourse)
  // Future<Response<List<CourseShortInfo>>> getCurrentCourse();
}

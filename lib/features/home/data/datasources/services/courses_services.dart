import 'package:chopper/chopper.dart';
import 'package:edulab_b2b/widget_imports.dart';

part 'courses_services.chopper.dart';

@ChopperApi(baseUrl: AppStrings.baseLive)
abstract class CourseServices extends ChopperService {
  static CourseServices create([ChopperClient? client]) =>
      _$CourseServices(client ?? ChopperClient());

  // course/all -> bare JSON array of courses (not the paged course/ list,
  // which is scoped to the caller and comes back empty for instructors).
  @Get(path: AppStrings.coursesAll)
  Future<Response<List<CourseShortInfo>>> getAllCourses();

  @Get(path: AppStrings.currentCourseAsUnauthorized)
  Future<Response<List<CourseShortInfo>>> getAllCoursesAsUnauthorized();

  // @Get(path: AppStrings.currentCourse)
  // Future<Response<List<CourseShortInfo>>> getCurrentCourse();
}

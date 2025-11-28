import 'package:chopper/chopper.dart';
import 'package:leti_mobile/widget_imports.dart';

part 'courses_services.chopper.dart';

@ChopperApi(baseUrl: AppStrings.baseLive)
abstract class CourseServices extends ChopperService {
  static CourseServices create([ChopperClient? client]) =>
      _$CourseServices(client ?? ChopperClient());

  @Get(path: AppStrings.categoryAll)
  Future<Response<List<CategoryModel>>> getAllCategories();

  @Get(path: AppStrings.coursesAll)
  Future<Response<List<CourseShortInfo>>> getAllPossibleCourses();

  @Get(path: AppStrings.currentCourse)
  Future<Response<List<CourseShortInfo>>> getCurrentCourse();

  @Get(path: '${AppStrings.coursesAll}?category_id={category_id}')
  Future<Response<List<CourseShortInfo>>> getCoursesByCategoryId(
    @Path('category_id') int category_id,
  );
}

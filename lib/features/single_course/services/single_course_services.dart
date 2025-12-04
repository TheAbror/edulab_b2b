import 'package:chopper/chopper.dart';
import 'package:leti_mobile/widget_imports.dart';

part 'single_course_services.chopper.dart';

@ChopperApi(baseUrl: AppStrings.baseLive)
abstract class SingleCourseServices extends ChopperService {
  static SingleCourseServices create([ChopperClient? client]) =>
      _$SingleCourseServices(client ?? ChopperClient());

  @Get(path: '${AppStrings.course}/{id}')
  Future<Response<SingleCourseInfo>> getSingleCourse(@Path('id') int id);

  @Get(path: '${AppStrings.checkEnrollment}/?course_id={id}')
  Future<Response<MobileResponse>> checkEnrollment(@Path('id') int id);

  @Get(path: AppStrings.course)
  Future<Response<SingleCourseInfo>> getSingleStepByID({
    @Query('chapter_id') required int chapterId,
    @Query('course_id') required int courseId,
    @Query('step_id') required int stepId,
    @Query('topic_id') required int topicId,
  });

  @Get(path: '${AppStrings.learningWithID}/{id}')
  Future<Response<SingleCourseInfo>> resumeCourseById(@Path('id') int id);

  @Post(path: AppStrings.submitQuiz)
  Future<Response<QuizResponse>> submitQuiz(@Body() QuizRequest body);

  @Post(path: AppStrings.addToFavorite)
  Future<Response<MobileResponse>> postCourseAsFavorite(
    @Body() MakeCourseFavoriteRequest body,
  );
}

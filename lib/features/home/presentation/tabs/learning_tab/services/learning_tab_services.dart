import 'package:chopper/chopper.dart';
import 'package:edulab_b2b/widget_imports.dart';

part 'learning_tab_services.chopper.dart';

@ChopperApi(baseUrl: AppStrings.baseLive)
abstract class LearningTabServices extends ChopperService {
  static LearningTabServices create([ChopperClient? client]) =>
      _$LearningTabServices(client ?? ChopperClient());

  @Get(path: AppStrings.learningTabInProgress)
  Future<Response<List<CourseShortInfo>>> getInProgress();

  @Get(path: AppStrings.learningTabCompleted)
  Future<Response<List<CourseShortInfo>>> getCompleted();

  @Get(path: AppStrings.statistics)
  Future<Response<LearningTabStatisticsResponse>> getStatistics();
}

import 'package:chopper/chopper.dart';
import 'package:leti_mobile/widget_imports.dart';

part 'learning_tab_services.chopper.dart';

@ChopperApi(baseUrl: AppStrings.baseLive)
abstract class LearningTabServices extends ChopperService {
  static LearningTabServices create([ChopperClient? client]) =>
      _$LearningTabServices(client ?? ChopperClient());

  @Get(path: AppStrings.learningTabInProgress)
  Future<Response<List<CourseShortInfo>>> getInProgress();

  @Get(path: AppStrings.learningTabCompleted)
  Future<Response<List<CourseShortInfo>>> getCompleted();

  @Get(path: AppStrings.learningTabFavorites)
  Future<Response<List<CourseShortInfo>>> getFavorites();

  @Get(path: AppStrings.statistics)
  Future<Response<LearningTabStatisticsResponse>> getStatistics();
}

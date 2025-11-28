// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_tab_services.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$LearningTabServices extends LearningTabServices {
  _$LearningTabServices([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = LearningTabServices;

  @override
  Future<Response<List<CourseShortInfo>>> getInProgress() {
    final Uri $url = Uri.parse(
        'https://leti.slash.uz/edulab_corp/api/v1/core/mobile/course/own?status=IN_PROGRESS');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<CourseShortInfo>, CourseShortInfo>($request);
  }

  @override
  Future<Response<List<CourseShortInfo>>> getCompleted() {
    final Uri $url = Uri.parse(
        'https://leti.slash.uz/edulab_corp/api/v1/core/mobile/course/own?status=COMPLETED');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<CourseShortInfo>, CourseShortInfo>($request);
  }

  @override
  Future<Response<List<CourseShortInfo>>> getFavorites() {
    final Uri $url = Uri.parse(
        'https://leti.slash.uz/edulab_corp/api/v1/core/mobile/course/own?status=FAVORITES');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<CourseShortInfo>, CourseShortInfo>($request);
  }

  @override
  Future<Response<LearningTabStatisticsResponse>> getStatistics() {
    final Uri $url = Uri.parse(
        'https://leti.slash.uz/edulab_corp/api/v1/core/mobile/statistics/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<LearningTabStatisticsResponse,
        LearningTabStatisticsResponse>($request);
  }
}

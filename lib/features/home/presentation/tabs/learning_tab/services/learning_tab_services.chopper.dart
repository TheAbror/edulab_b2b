// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

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
      'https://944b-213-230-79-129.ngrok-free.app/course/own?status=IN_PROGRESS',
    );
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<List<CourseShortInfo>, CourseShortInfo>($request);
  }

  @override
  Future<Response<List<CourseShortInfo>>> getCompleted() {
    final Uri $url = Uri.parse(
      'https://944b-213-230-79-129.ngrok-free.app/course/own?status=COMPLETED',
    );
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<List<CourseShortInfo>, CourseShortInfo>($request);
  }

  @override
  Future<Response<LearningTabStatisticsResponse>> getStatistics() {
    final Uri $url = Uri.parse(
      'https://944b-213-230-79-129.ngrok-free.app/statistics/',
    );
    final Request $request = Request('GET', $url, client.baseUrl);
    return client
        .send<LearningTabStatisticsResponse, LearningTabStatisticsResponse>(
          $request,
        );
  }
}

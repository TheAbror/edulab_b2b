// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_course_services.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$SingleCourseServices extends SingleCourseServices {
  _$SingleCourseServices([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = SingleCourseServices;

  @override
  Future<Response<SingleCourseInfo>> getSingleCourseByItsId(int id) {
    final Uri $url = Uri.parse(
        'https://leti.slash.uz/edulab_corp/api/v1/core/mobile/course/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<SingleCourseInfo, SingleCourseInfo>($request);
  }

  @override
  Future<Response<SingleCourseInfo>> resumeCourseById(int id) {
    final Uri $url = Uri.parse(
        'https://leti.slash.uz/edulab_corp/api/v1/core/mobile/learning/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<SingleCourseInfo, SingleCourseInfo>($request);
  }

  @override
  Future<Response<MobileResponse>> postCourseAsFavorite(
      MakeCourseFavoriteRequest body) {
    final Uri $url = Uri.parse(
        'https://leti.slash.uz/edulab_corp/api/v1/core/mobile/course/add-to-favorites');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<MobileResponse, MobileResponse>($request);
  }
}

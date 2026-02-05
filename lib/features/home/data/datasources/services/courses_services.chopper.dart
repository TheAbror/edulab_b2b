// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'courses_services.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$CourseServices extends CourseServices {
  _$CourseServices([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = CourseServices;

  @override
  Future<Response<List<CategoryModel>>> getAllCategories() {
    final Uri $url = Uri.parse(
      'https://leti.slash.uz/edulab_corp/api/v1/core/mobile/category/all',
    );
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<List<CategoryModel>, CategoryModel>($request);
  }

  @override
  Future<Response<HomeCoursesResponse>> getAllCourses() {
    final Uri $url = Uri.parse(
      'https://leti.slash.uz/edulab_corp/api/v1/core/mobile/course/',
    );
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<HomeCoursesResponse, HomeCoursesResponse>($request);
  }

  @override
  Future<Response<HomeCoursesResponse>> getAllCoursesAsUnauthorized() {
    final Uri $url = Uri.parse(
      'https://leti.slash.uz/edulab_corp/api/v1/core/mobile/public/course/all',
    );
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<HomeCoursesResponse, HomeCoursesResponse>($request);
  }

  @override
  Future<Response<List<CourseShortInfo>>> getCurrentCourse() {
    final Uri $url = Uri.parse(
      'https://leti.slash.uz/edulab_corp/api/v1/core/mobile/course/own',
    );
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<List<CourseShortInfo>, CourseShortInfo>($request);
  }

  @override
  Future<Response<List<CourseShortInfo>>> getCoursesByCategoryId(
    int category_id,
  ) {
    final Uri $url = Uri.parse(
      'https://leti.slash.uz/edulab_corp/api/v1/core/mobile/course/all?category_id=${category_id}',
    );
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<List<CourseShortInfo>, CourseShortInfo>($request);
  }
}

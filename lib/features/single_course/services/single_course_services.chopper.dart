// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

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
  Future<Response<SingleCourseInfo>> getSingleCourse(int id) {
    final Uri $url = Uri.parse(
      'https://leti.slash.uz/edulab_corp/api/v1/core/mobile/course/${id}',
    );
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<SingleCourseInfo, SingleCourseInfo>($request);
  }

  @override
  Future<Response<SingleCourseInfo>> getSingleCourseAsUnathorized(int id) {
    final Uri $url = Uri.parse(
      'https://leti.slash.uz/edulab_corp/api/v1/core/mobile/public/course/${id}',
    );
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<SingleCourseInfo, SingleCourseInfo>($request);
  }

  @override
  Future<Response<CheckEnrollmentResponse>> checkEnrollment(int id) {
    final Uri $url = Uri.parse(
      'https://leti.slash.uz/edulab_corp/api/v1/core/mobile/enrollment/check/?course_id=${id}',
    );
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<CheckEnrollmentResponse, CheckEnrollmentResponse>(
      $request,
    );
  }

  @override
  Future<Response<CourseEnrollmentResponse>> enrollToCourse(
    EnrollmentRequest body,
  ) {
    final Uri $url = Uri.parse(
      'https://leti.slash.uz/edulab_corp/api/v1/core/mobile/enrollment/',
    );
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<CourseEnrollmentResponse, CourseEnrollmentResponse>(
      $request,
    );
  }

  @override
  Future<Response<StepModel>> openSelectedTopic({
    required int chapterId,
    required int courseId,
    required int stepId,
    required int topicId,
  }) {
    final Uri $url = Uri.parse(
      'https://leti.slash.uz/edulab_corp/api/v1/core/mobile/learning/',
    );
    final Map<String, dynamic> $params = <String, dynamic>{
      'chapter_id': chapterId,
      'course_id': courseId,
      'step_id': stepId,
      'topic_id': topicId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<StepModel, StepModel>($request);
  }

  @override
  Future<Response<CourseProgressModel>> completeStep(CompleteStepRequest body) {
    final Uri $url = Uri.parse(
      'https://leti.slash.uz/edulab_corp/api/v1/core/mobile/learning/complete',
    );
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<CourseProgressModel, CourseProgressModel>($request);
  }

  @override
  Future<Response<SingleCourseInfo>> resumeCourseById(int id) {
    final Uri $url = Uri.parse(
      'https://leti.slash.uz/edulab_corp/api/v1/core/mobile/learning/${id}',
    );
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<SingleCourseInfo, SingleCourseInfo>($request);
  }

  @override
  Future<Response<QuizResponse>> submitQuiz(QuizRequest body) {
    final Uri $url = Uri.parse(
      'https://leti.slash.uz/edulab_corp/api/v1/core/mobile/learning/submit',
    );
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<QuizResponse, QuizResponse>($request);
  }

  @override
  Future<Response<MobileResponse>> postCourseAsFavorite(
    MakeCourseFavoriteRequest body,
  ) {
    final Uri $url = Uri.parse(
      'https://leti.slash.uz/edulab_corp/api/v1/core/mobile/course/add-to-favorites',
    );
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<MobileResponse, MobileResponse>($request);
  }
}

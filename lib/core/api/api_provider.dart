import 'package:leti_mobile/features/single_course/services/single_course_services.dart';
import 'package:leti_mobile/widget_imports.dart';
import 'package:chopper/chopper.dart';
import 'package:http/io_client.dart' as http;

class ApiProvider {
  static late ChopperClient _client;
  static late AppVersionService versions;
  static late AuthService authService;
  static late HomeServices homeServices;
  static late CourseServices coursesServices;
  static late SingleCourseServices singleCourseServices;
  static late LearningTabServices learningTabServices;

  ///Services
  static create({String? token, String? language}) {
    _client = ChopperClient(
      client: http.IOClient(
        HttpClient()..connectionTimeout = const Duration(seconds: 20),
      ),
      services: [
        AppVersionService.create(),
        AuthService.create(),
        HomeServices.create(),
        CourseServices.create(),
        SingleCourseServices.create(),
        LearningTabServices.create(),
      ],
      interceptors: getInterceptors(),
      converter: CustomDataConverter(),
    );

    versions = _client.getService<AppVersionService>();
    authService = _client.getService<AuthService>();
    homeServices = _client.getService<HomeServices>();
    coursesServices = _client.getService<CourseServices>();
    singleCourseServices = _client.getService<SingleCourseServices>();
    learningTabServices = _client.getService<LearningTabServices>();
  }

  static NotAuthorizedInterceptor notAuthorizedInterceptor =
      NotAuthorizedInterceptor();

  static getInterceptors({String? language}) {
    final String? token = PreferencesServices.getToken();

    List<Interceptor> interceptors = [];

    interceptors.add(HttpLoggingInterceptor());

    interceptors.add(notAuthorizedInterceptor);

    interceptors.add(
      HeadersInterceptor({
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: token == null ? '' : 'Bearer $token',
      }),
    );

    return interceptors;
  }

  static dispose() {
    _client.dispose();
  }
}

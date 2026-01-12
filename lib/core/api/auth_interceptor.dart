import 'package:chopper/chopper.dart';
import 'package:leti_mobile/widget_imports.dart';

class NotAuthorizedInterceptor implements Interceptor {
  final StreamController<bool> controller = StreamController<bool>.broadcast();

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
    Chain<BodyType> chain,
  ) async {
    final response = await chain.proceed(chain.request);

    final token = PreferencesServices.getToken();
    if (token != null && token.isNotEmpty) {
      if (response.statusCode == 401) {
        controller.add(true);
      }
    }

    return response;
  }
}

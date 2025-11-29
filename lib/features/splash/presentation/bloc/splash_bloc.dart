import 'package:leti_mobile/widget_imports.dart';

part 'splash_state.dart';

class SplashBloc extends Cubit<SplashState> {
  SplashBloc() : super(SplashState.initial());

  Future setupInitialSettings() async {
    final String? token = PreferencesServices.getToken();

    ApiProvider.create(token: token ?? '');

    if (token != null && token.isNotEmpty == true) {
      emit(state.copyWith(authStatus: SplashAuthStatus.authorized));
    } else {
      emit(state.copyWith(authStatus: SplashAuthStatus.notAuthorized));
    }
  }

  void clearAll() {
    emit(SplashState.initial());
  }
}

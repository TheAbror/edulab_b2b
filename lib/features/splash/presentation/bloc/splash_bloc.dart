import 'package:leti_mobile/widget_imports.dart';

part 'splash_state.dart';

class SplashBloc extends Cubit<SplashState> {
  SplashBloc() : super(SplashState.initial());

  Future<void> setupInitialSettings() async {
    await Future.delayed(const Duration(seconds: 2));

    final String? token = PreferencesServices.getToken();

    ApiProvider.create(token: token ?? '');

    if (token != null && token.isNotEmpty) {
      emit(state.copyWith(authStatus: SplashAuthStatus.authorized));
    } else {
      emit(state.copyWith(authStatus: SplashAuthStatus.notAuthorized));
    }
  }

  void clearAll() {
    emit(SplashState.initial());
  }
}

import 'package:leti_mobile/widget_imports.dart';

part 'localization_state.dart';

class LocalizationBloc extends Cubit<LocalizationState> {
  LocalizationBloc() : super(LocalizationState.initial());

  Future<void> initLocalization() async {
    var deviceLang = Platform.localeName.splitLangCodeFromLocale();
    final lang = PreferencesServices.getLang();
    final token = PreferencesServices.getToken();

    final userLang = lang ?? deviceLang;

    PreferencesServices.saveLang(getLanguageCode(userLang));

    ApiProvider.create(token: token, language: getLanguageCode(userLang));

    emit(state.copyWith(languageCode: getLanguageCode(userLang)));
  }

  Future<void> changeLocalization(String? languageCode) async {
    var deviceLang = Platform.localeName.splitLangCodeFromLocale();
    final token = PreferencesServices.getToken();
    deviceLang = getLanguageName(deviceLang);

    final currentAppLang = languageCode ?? deviceLang;

    PreferencesServices.saveLang(currentAppLang);

    ApiProvider.create(token: token, language: currentAppLang);

    emit(state.copyWith(languageCode: currentAppLang));
  }

  void clearAll() {
    emit(LocalizationState.initial());
  }
}

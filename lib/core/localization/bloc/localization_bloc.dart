import 'package:edulab_b2b/widget_imports.dart';

part 'localization_state.dart';

class LocalizationBloc extends Cubit<LocalizationState> {
  LocalizationBloc() : super(LocalizationState.initial());

  Future<void> initLocalization() async {
    var deviceLangCode = Platform.localeName.splitLangCodeFromLocale();
    final langCode = PreferencesServices.getLangCode();
    final token = PreferencesServices.getToken();

    final userLang = langCode ?? deviceLangCode;

    PreferencesServices.saveLangCode(userLang);

    ApiProvider.create(token: token, language: userLang);

    emit(state.copyWith(languageCode: userLang));
  }

  Future<void> changeLocalization(String? languageCode) async {
    var deviceLang = Platform.localeName.splitLangCodeFromLocale();
    final token = PreferencesServices.getToken();
    final lang = languageCode ?? deviceLang;

    PreferencesServices.saveLangCode(lang);

    ApiProvider.create(token: token, language: lang);

    emit(state.copyWith(languageCode: lang));
  }

  void clearAll() {
    emit(LocalizationState.initial());
  }
}

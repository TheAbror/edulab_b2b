import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leti_mobile/core/extensions/string_extensions.dart';

part 'localization_state.dart';

class LocalizationBloc extends Cubit<LocalizationState> {
  LocalizationBloc() : super(LocalizationState.initial());

  Future<void> initLocalization() async {
    var deviceLang = Platform.localeName.splitLangCodeFromLocale();
    // final currentUser = userBox.get(ShPrefKeys.currentUser);
    // final settings = settingsBox.get(ShPrefKeys.projectSettings);

    deviceLang = getLanguageName(deviceLang);

    // final userLang = settings?.lang ?? deviceLang;

    // if (settings != null) {
    //   settingsBox.put(
    //     ShPrefKeys.projectSettings,
    //     settings.copyWith(lang: userLang),
    //   );
    // } else {
    //   settingsBox.put(
    //     ShPrefKeys.projectSettings,
    //     ProjectSettings(isLight: false, isSystemDefault: true, lang: userLang),
    //   );
    // }

    // ApiProvider.create(token: currentUser?.token, language: userLang);

    emit(state.copyWith(languageCode: 'en'));
    // emit(state.copyWith(languageCode: userLang));
  }

  Future<void> changeLocalization(String? languageCode) async {
    var deviceLang = Platform.localeName.splitLangCodeFromLocale();

    // final currentUser = userBox.get(ShPrefKeys.currentUser);

    // final settings = settingsBox.get(ShPrefKeys.projectSettings);

    deviceLang = getLanguageName(deviceLang);

    final currentAppLang = languageCode ?? deviceLang;

    // settingsBox.put(
    //   ShPrefKeys.projectSettings,
    //   settings.copyWith(lang: currentAppLang),
    // );

    // ApiProvider.create(token: currentUser?.token, language: currentAppLang);

    emit(state.copyWith(languageCode: currentAppLang));
  }

  void clearAll() {
    emit(LocalizationState.initial());
  }
}

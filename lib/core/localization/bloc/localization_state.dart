part of 'localization_bloc.dart';

class LocalizationState extends Equatable {
  final String languageCode;

  const LocalizationState({
    required this.languageCode,
  });

  factory LocalizationState.initial() {
    var deviceLang = Platform.localeName.splitLangCodeFromLocale();

    return LocalizationState(languageCode: deviceLang);
  }

  LocalizationState copyWith({
    String? languageCode,
  }) {
    return LocalizationState(
      languageCode: languageCode ?? this.languageCode,
    );
  }

  @override
  List<Object?> get props => [languageCode];
}

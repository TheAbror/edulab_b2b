import 'package:intl/intl.dart';
import 'package:edulab_b2b/widget_imports.dart';

extension NullableStringExtensions on String? {
  bool get isNotNullAndNotEmpty {
    final value = this;

    if (value != null && value.isNotEmpty) {
      return true;
    }

    return false;
  }
}

extension StringExtensions on String {
  String splitLangCodeFromLocale() {
    return split('_').first;
  }
}

extension StringMakeFirstCap on String {
  String makeFirstCapital() {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}

String returnLanguageName(String languageCode) {
  switch (languageCode) {
    case 'uz':
      return 'O’zbek';
    case 'ru':
      return 'Русский';
    case 'en':
      return 'English';
    default:
      return 'Русский';
  }
}

String returnLanguageCode(String languageCode) {
  switch (languageCode) {
    case 'O’zbek':
      return 'uz';
    case 'Русский':
      return 'ru';
    case 'English':
      return 'en';
    default:
      return 'ru';
  }
}

extension HumanReadableDate on DateTime? {
  String get humanReadable {
    return DateFormat('dd-MMMM-yyyy').format(this ?? DateTime(2024));
  }
}

extension CustomColorsContext on BuildContext {
  CustomColors get colors => Theme.of(this).extension<CustomColors>()!;
}

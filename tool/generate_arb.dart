import 'dart:convert';
import 'dart:io';

const _locales = ['en', 'ru', 'uz'];
const _translationsDir = 'assets/translations';
const _arbDir = 'lib/l10n';

void main() {
  for (final locale in _locales) {
    final jsonFile = File('$_translationsDir/$locale.json');
    final Map<String, dynamic> translations = jsonDecode(jsonFile.readAsStringSync());

    final arb = <String, dynamic>{'@@locale': locale};
    translations.forEach((key, value) {
      arb[key] = value;
      arb['@$key'] = <String, dynamic>{};
    });

    final encoder = JsonEncoder.withIndent('  ');
    File('$_arbDir/app_$locale.arb').writeAsStringSync(encoder.convert(arb));
  }

  stdout.writeln('Generated ARB files for: ${_locales.join(', ')}');
}

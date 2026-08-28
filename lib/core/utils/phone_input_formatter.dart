import 'package:flutter/services.dart';

/// Uzbek phone numbers are shown as `+998 90 123 45 67` while the API is fed
/// the digits only (`+998901234567`).
const _countryCode = '998';
const _subscriberLength = 9;
const _groups = [2, 3, 2, 2];

final _nonDigits = RegExp(r'[^0-9]');

/// Every digit of [value], country code included.
String phoneDigits(String value) => value.replaceAll(_nonDigits, '');

/// The value the backend expects: `+998901234567`.
String phoneApiValue(String value) => '+${phoneDigits(value)}';

/// True once the country code and all nine subscriber digits are present.
bool isPhoneComplete(String value) =>
    phoneDigits(value).length == _countryCode.length + _subscriberLength;

/// Renders [value] as `+998 90 123 45 67`, keeping partial input partial.
String formatPhone(String value) {
  final subscriber = _subscriberDigits(value);
  if (subscriber.isEmpty && phoneDigits(value).isEmpty) return '';

  final buffer = StringBuffer('+$_countryCode');
  var index = 0;
  for (final group in _groups) {
    if (index >= subscriber.length) break;
    final end = (index + group).clamp(0, subscriber.length);
    buffer.write(' ${subscriber.substring(index, end)}');
    index = end;
  }
  return buffer.toString();
}

/// The nine digits after the country code, tolerating pasted numbers and
/// edits that chew into the `998` prefix.
String _subscriberDigits(String value) {
  final digits = phoneDigits(value);
  String subscriber;
  if (digits.startsWith(_countryCode)) {
    subscriber = digits.substring(_countryCode.length);
  } else if (digits.length >= _subscriberLength) {
    subscriber = digits.substring(digits.length - _subscriberLength);
  } else {
    // A partially typed or partially deleted country code.
    var matched = 0;
    while (matched < _countryCode.length &&
        matched < digits.length &&
        digits[matched] == _countryCode[matched]) {
      matched++;
    }
    subscriber = digits.substring(matched);
  }

  return subscriber.length > _subscriberLength
      ? subscriber.substring(0, _subscriberLength)
      : subscriber;
}

/// Keeps a phone field rendered as `+998 90 123 45 67`.
class PhoneInputFormatter extends TextInputFormatter {
  const PhoneInputFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final formatted = formatPhone(newValue.text);
    if (formatted.isEmpty) return TextEditingValue.empty;

    final cursor = newValue.selection.end.clamp(0, newValue.text.length);
    final digitsBeforeCursor = phoneDigits(
      newValue.text.substring(0, cursor),
    ).length;

    var offset = 0;
    var seen = 0;
    while (offset < formatted.length && seen < digitsBeforeCursor) {
      if (!_nonDigits.hasMatch(formatted[offset])) seen++;
      offset++;
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: offset),
    );
  }
}

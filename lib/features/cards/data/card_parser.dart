import '../../../core/utils/luhn_validator.dart';
import '../domain/entity/card_entity.dart';

class CardParser {
  CardEntity parse(String rawText) {
    final cleaned = _cleanText(rawText);

    final cardNumber = _extractCardNumber(cleaned);
    final expiry = _extractExpiry(cleaned);
    final name = _extractName(cleaned);

    final isValid = cardNumber != null && LuhnValidator.isValid(cardNumber);

    return CardEntity(
      cardNumber: cardNumber ?? '',
      expiry: expiry,
      holderName: name,
      isValid: isValid,
    );
  }

  String _cleanText(String text) {
    return text
        .replaceAll('l', '1') // keep minimal safe replacements
        .replaceAll(RegExp(r'[^\x00-\x7F]+'), ''); // remove weird chars
  }

  String? _extractCardNumber(String text) {
    final regex = RegExp(r'\b(?:\d[ -]*?){13,19}\b');

    final match = regex.firstMatch(text);
    if (match == null) return null;

    final number = match.group(0)!.replaceAll(RegExp(r'\D'), '');

    return number;
  }

  String? _extractExpiry(String text) {
    final regex = RegExp(r'(0[1-9]|1[0-2])\/([0-9]{2})');
    final match = regex.firstMatch(text);

    return match?.group(0);
  }

  String? _extractName(String text) {
    // First try labeled extraction
    final regex = RegExp(
      r'(?:NAME|CARDHOLDER NAME|CARD HOLDER)\s*[:\-]?\s*([A-Z ]{3,})',
      caseSensitive: false,
    );

    final match = regex.firstMatch(text);

    if (match != null) {
      return match.group(1)?.trim();
    }

    // 🔥 Fallback: detect standalone uppercase name
    final lines = text.split('\n');

    for (final line in lines) {
      final cleanedLine = line.trim();

      if (RegExp(r'^[A-Z ]{5,}$').hasMatch(cleanedLine)) {
        return cleanedLine;
      }
    }

    return null;
  }
}
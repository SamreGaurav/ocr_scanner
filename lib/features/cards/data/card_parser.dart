import '../../../core/utils/luhn_validator.dart';
import '../domain/entity/card_entity.dart';

class CardParser {
  CardEntity parse(String rawText) {
    final cleaned = _cleanText(rawText);

    final cardNumber = _extractCardNumber(cleaned);
    final expiry = _extractExpiry(cleaned);
    final name = _extractName(cleaned);

    if (cardNumber == null ||
        !LuhnValidator.isValid(cardNumber)) {
      throw Exception("Invalid card");
    }

    return CardEntity(
      cardNumber: cardNumber,
      expiry: expiry,
      holderName: name,
    );
  }

  String _cleanText(String text) {
    return text
        .replaceAll('O', '0')
        .replaceAll('I', '1')
        .replaceAll('l', '1');
  }

  String? _extractCardNumber(String text) {
    final regex = RegExp(r'\b(?:\d[ -]*?){13,19}\b');

    final match = regex.firstMatch(text);
    if (match == null) return null;

    final number = match.group(0)!.replaceAll(RegExp(r'\D'), '');

    return number;
  }

  String? _extractExpiry(String text) {
    final regex = RegExp(r'(0[1-9]|1[0-2])[/\-]?\d{2,4}');
    final match = regex.firstMatch(text);

    return match?.group(0);
  }

  String? _extractName(String text) {
    final lines = text.split('\n');

    for (var line in lines) {
      if (RegExp(r'^[A-Z ]{5,}$').hasMatch(line)) {
        return line.trim();
      }
    }

    return null;
  }
}
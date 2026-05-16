import 'package:flutter_test/flutter_test.dart';
import 'package:scanner_app/features/cards/data/card_parser.dart';

void main() {
  late CardParser parser;

  setUp(() {
    parser = CardParser();
  });

  group('Card Parser Tests', () {
    test('Should correctly parse valid card details', () {
      const rawText = '''
      CARD NUMBER: 4539 1488 0343 6467
      EXP: 12/28
      NAME: JOHN DOE
      ''';

      final result = parser.parse(rawText);

      expect(result.cardNumber, '4539148803436467');
      expect(result.expiry, '12/28');
      expect(result.holderName, 'JOHN DOE');
      expect(result.isValid, true);
    });

    test('Should handle noisy OCR text', () {
      const rawText = '''
      4539 1488 0343 6467
      VALID THRU 12/28
      JOHN DOE
      ''';

      final result = parser.parse(rawText);

      expect(result.cardNumber, isNotNull);
      expect(result.expiry, isNotNull);
      expect(result.holderName, isNotNull);
    });

    test('Invalid card should fail Luhn validation', () {
      const rawText = '''
      1234 5678 1234 5678
      EXP: 10/25
      NAME: TEST USER
      ''';

      final result = parser.parse(rawText);

      expect(result.isValid, false);
    });
  });
}
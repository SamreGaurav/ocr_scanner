import 'package:flutter_test/flutter_test.dart';
import 'package:scanner_app/features/passbook/data/passbook_parser.dart';

void main() {
  late PassbookParser parser;

  setUp(() {
    parser = PassbookParser();
  });

  group('Passbook Parser Tests', () {
    test('Should correctly parse passbook details', () {
      const rawText = '''
      Account No: 123456789012
      IFSC: SBIN0001234
      Name: RAHUL SHARMA
      ''';

      final result = parser.parse(rawText);

      expect(result.accountNumber, '123456789012');
      expect(result.ifsc, 'SBIN0001234');
      expect(result.holderName, 'RAHUL SHARMA');
    });

    test('Should handle OCR variations', () {
      const rawText = '''
      A/C NO - 987654321098
      IFSC CODE: HDFC0005678
      CUSTOMER NAME: AMIT KUMAR
      ''';

      final result = parser.parse(rawText);

      expect(result.accountNumber, isNotNull);
      expect(result.ifsc, isNotNull);
      expect(result.holderName, isNotNull);
    });

    test('Should return nulls for missing data', () {
      const rawText = 'Random text without useful info';

      final result = parser.parse(rawText);

      expect(result.accountNumber, isNull);
      expect(result.ifsc, isNull);
      expect(result.holderName, isNull);
    });
  });
}
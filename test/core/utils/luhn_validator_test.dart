import 'package:flutter_test/flutter_test.dart';
import 'package:scanner_app/core/utils/luhn_validator.dart';

void main() {
  group('Luhn Validator Tests', () {
    test('Valid card number should return true', () {
      final result = LuhnValidator.isValid('4539148803436467');
      expect(result, true);
    });

    test('Invalid card number should return false', () {
      final result = LuhnValidator.isValid('1234567812345678');
      expect(result, false);
    });

    test('Card number with spaces should still validate', () {
      final result = LuhnValidator.isValid('4539 1488 0343 6467');
      expect(result, true);
    });

    test('Empty input should return false', () {
      final result = LuhnValidator.isValid('');
      expect(result, false);
    });
  });
}
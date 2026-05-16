class LuhnValidator {
  static bool isValid(String? input) {
    if (input == null || input.trim().isEmpty) return false;

    final sanitized = input.replaceAll(RegExp(r'\s+'), '');

    if (!RegExp(r'^\d+$').hasMatch(sanitized)) return false;

    int sum = 0;
    bool alternate = false;

    for (int i = sanitized.length - 1; i >= 0; i--) {
      int n = int.parse(sanitized[i]);

      if (alternate) {
        n *= 2;
        if (n > 9) n -= 9;
      }

      sum += n;
      alternate = !alternate;
    }

    return sum % 10 == 0;
  }
}
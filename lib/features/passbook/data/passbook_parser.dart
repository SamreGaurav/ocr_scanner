import '../domain/entity/bank_entity.dart';

class PassbookParser {
  BankEntity parse(String rawText) {
    final text = rawText.toUpperCase();

    final accountNumber = _extractAccountNumber(text);
    final ifsc = _extractIFSC(text);
    final name = _extractName(text);

    return BankEntity(
      accountNumber: accountNumber,
      ifsc: ifsc,
      holderName: name,
    );
  }

  String? _extractAccountNumber(String text) {
    final regex = RegExp(r'\b\d{9,18}\b');

    final matches = regex.allMatches(text);

    // choose longest (most likely real)
    String? best;
    for (var m in matches) {
      final val = m.group(0)!;
      if (best == null || val.length > best.length) {
        best = val;
      }
    }

    return best;
  }

  String? _extractIFSC(String text) {
    final regex = RegExp(r'[A-Z]{4}0[A-Z0-9]{6}');
    return regex.firstMatch(text)?.group(0);
  }

  String? _extractName(String text) {
    final lines = text.split('\n');

    for (var line in lines) {
      if (line.contains("NAME")) {
        return line.replaceAll("NAME", "").trim();
      }
    }

    return null;
  }
}
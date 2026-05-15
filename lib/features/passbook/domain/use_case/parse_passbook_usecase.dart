import '../../data/passbook_parser.dart';
import '../entity/bank_entity.dart';

class ParsePassbookUsecase {
  final PassbookParser parser;

  ParsePassbookUsecase(this.parser);

  BankEntity call(String rawText) {
    return parser.parse(rawText);
  }
}
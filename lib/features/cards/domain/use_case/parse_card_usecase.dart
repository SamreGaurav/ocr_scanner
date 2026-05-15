import '../../data/card_parser.dart';
import '../entity/card_entity.dart';

class ParseCardUsecase {
  final CardParser parser;

  ParseCardUsecase(this.parser);

  CardEntity call(String rawText) {
    return parser.parse(rawText);
  }
}
abstract class CardEvent {}

class ScanCardEvent extends CardEvent {
  final String rawText;

  ScanCardEvent(this.rawText);
}
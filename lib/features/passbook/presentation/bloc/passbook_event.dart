abstract class PassbookEvent {}

class ScanPassbookEvent extends PassbookEvent {
  final String rawText;

  ScanPassbookEvent(this.rawText);
}
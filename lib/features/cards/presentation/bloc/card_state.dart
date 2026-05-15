
import '../../domain/entity/card_entity.dart';

abstract class CardState {}

class CardInitial extends CardState {}

class CardLoading extends CardState {}

class CardSuccess extends CardState {
  final CardEntity card;

  CardSuccess(this.card);
}

class CardError extends CardState {
  final String message;

  CardError(this.message);
}
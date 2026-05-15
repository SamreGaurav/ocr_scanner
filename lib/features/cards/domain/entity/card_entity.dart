import 'package:equatable/equatable.dart';

class CardEntity extends Equatable {
  final String cardNumber;
  final String? expiry;
  final String? holderName;

  const CardEntity({
    required this.cardNumber,
    this.expiry,
    this.holderName,
  });

  @override
  List<Object?> get props => [cardNumber, expiry, holderName];
}
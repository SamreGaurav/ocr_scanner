import 'package:equatable/equatable.dart';

class BankEntity extends Equatable {
  final String? accountNumber;
  final String? ifsc;
  final String? holderName;

  const BankEntity({
    this.accountNumber,
    this.ifsc,
    this.holderName,
  });

  @override
  List<Object?> get props => [accountNumber, ifsc, holderName];
}
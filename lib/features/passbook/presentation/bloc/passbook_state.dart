
import 'package:scanner_app/features/passbook/domain/entity/bank_entity.dart';

abstract class PassbookState {}

class PassbookInitial extends PassbookState {}

class PassbookLoading extends PassbookState {}

class PassbookSuccess extends PassbookState {
  final BankEntity data;

  PassbookSuccess(this.data);
}

class PassbookError extends PassbookState {
  final String message;

  PassbookError(this.message);
}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner_app/features/passbook/domain/use_case/parse_passbook_usecase.dart';
import '../bloc/passbook_event.dart';
import '../bloc/passbook_state.dart';

class PassbookBloc extends Bloc<PassbookEvent, PassbookState> {
  final ParsePassbookUsecase usecase;

  PassbookBloc(this.usecase) : super(PassbookInitial()) {
    on<ScanPassbookEvent>((event, emit) {
      emit(PassbookLoading());

      try {
        final result = usecase(event.rawText);
        emit(PassbookSuccess(result));
      } catch (e) {
        emit(PassbookError("Parsing failed"));
      }
    });
  }
}
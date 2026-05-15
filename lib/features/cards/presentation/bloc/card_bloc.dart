import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_case/parse_card_usecase.dart';
import 'card_event.dart';
import 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final ParseCardUsecase usecase;

  CardBloc(this.usecase) : super(CardInitial()) {
    on<ScanCardEvent>((event, emit) async {
      emit(CardLoading());

      try {
        final result = usecase(event.rawText);
        emit(CardSuccess(result));
      } catch (e) {
        emit(CardError("Invalid card data"));
      }
    });
  }
}
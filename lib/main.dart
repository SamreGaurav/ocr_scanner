import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner_app/app/home/presentation/home_screen.dart';
import 'package:scanner_app/features/cards/data/card_parser.dart';
import 'package:scanner_app/features/cards/domain/use_case/parse_card_usecase.dart';
import 'package:scanner_app/features/cards/presentation/bloc/card_bloc.dart';
import 'package:scanner_app/features/passbook/domain/use_case/parse_passbook_usecase.dart';
import 'features/passbook/data/passbook_parser.dart';
import 'features/passbook/presentation/bloc/passbook_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CardBloc(
            ParseCardUsecase(CardParser()),
          ),
        ),
        BlocProvider(
          create: (_) => PassbookBloc(
            ParsePassbookUsecase(PassbookParser()),
          ),
        ),
      ],
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
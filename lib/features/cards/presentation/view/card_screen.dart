import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner_app/core/services/image_picker_service.dart';
import 'package:scanner_app/core/services/ocr_service.dart';
import 'package:scanner_app/features/scanner/usecase/scan_and_extract_text.dart';
import '../bloc/card_bloc.dart';
import '../bloc/card_event.dart';
import '../bloc/card_state.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Card Scanner")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async{
              final scanner = ScanAndExtractText(
                ImagePickerService(),
                OCRService(),
              );

              final rawText = await scanner.scanFromCamera();
              print('Raw text : $rawText');
              if (rawText != null && rawText.isNotEmpty) {
                context.read<CardBloc>().add(
                  ScanCardEvent(rawText),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("No text detected")),
                );
              }
            },
            child: Text("Scan Card"),
          ),
          BlocBuilder<CardBloc, CardState>(
            builder: (context, state) {
              if (state is CardLoading) {
                return CircularProgressIndicator();
              } else if (state is CardSuccess) {
                return Column(
                  children: [
                    Text("Number: ${_mask(state.card.cardNumber)}"),
                    Text("Expiry: ${state.card.expiry}"),
                    Text("Name: ${state.card.holderName}"),
                  ],
                );
              } else if (state is CardError) {
                return Text(state.message);
              }
              return Container();
            },
          )
        ],
      ),
    );
  }

  String _mask(String number) {
    return "XXXX XXXX XXXX ${number.substring(number.length - 4)}";
  }
}
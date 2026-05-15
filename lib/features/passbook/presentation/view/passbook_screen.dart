import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/image_picker_service.dart';
import '../../../../core/services/ocr_service.dart';
import '../../../scanner/usecase/scan_and_extract_text.dart';

import '../bloc/passbook_bloc.dart';
import '../bloc/passbook_event.dart';
import '../bloc/passbook_state.dart';

class PassbookScreen extends StatefulWidget {
  const PassbookScreen({super.key});

  @override
  State<PassbookScreen> createState() => _PassbookScreenState();
}

class _PassbookScreenState extends State<PassbookScreen> {
  String? imagePath;

  final scanner = ScanAndExtractText(
    ImagePickerService(),
    OCRService(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Passbook Scanner")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 📸 Image Preview
            if (imagePath != null)
              Image.file(
                File(imagePath!),
                height: 200,
              ),

            const SizedBox(height: 20),

            // 📸 Scan Button
            ElevatedButton(
              onPressed: () async {
                final image =
                await ImagePickerService().pickFromCamera();

                if (image == null) return;

                setState(() {
                  imagePath = image.path;
                });

                final rawText =
                await OCRService().extractText(image.path);

                print("PASSBOOK OCR:\n$rawText");

                if (rawText.isNotEmpty) {
                  context
                      .read<PassbookBloc>()
                      .add(ScanPassbookEvent(rawText));
                } else {
                  _showError("No text detected");
                }
              },
              child: Text("Scan Passbook"),
            ),

            const SizedBox(height: 20),

            // 🔄 State UI
            Expanded(
              child: BlocBuilder<PassbookBloc, PassbookState>(
                builder: (context, state) {
                  if (state is PassbookLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (state is PassbookSuccess) {
                    final data = state.data;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildField(
                            "Account Number", data.accountNumber),
                        _buildField("IFSC", data.ifsc),
                        _buildField("Name", data.holderName),
                      ],
                    );
                  }

                  if (state is PassbookError) {
                    return Center(child: Text(state.message));
                  }

                  return Center(child: Text("No data yet"));
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildField(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        "$title: ${value ?? "Not found"}",
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }
}
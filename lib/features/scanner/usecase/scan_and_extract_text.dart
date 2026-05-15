import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/services/image_picker_service.dart';
import '../../../core/services/ocr_service.dart';

class ScanAndExtractText {
  final ImagePickerService picker;
  final OCRService ocr;

  ScanAndExtractText(this.picker, this.ocr);

  Future<String?> scanFromCamera() async {
    ///To use camera image
    final image = await picker.pickFromCamera();
    if (image == null) return null;

    /// To use asset image
   /* final byteData = await rootBundle.load('assets/card.png');

    // 2. Convert to file in temp directory
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/test_image.png');

    await file.writeAsBytes(byteData.buffer.asUint8List());
*/
    return await ocr.extractText(image.path);
  }

  Future<String?> scanFromGallery() async {
    final image = await picker.pickFromGallery();
    if (image == null) return null;

    return await ocr.extractText(image.path);
  }
}
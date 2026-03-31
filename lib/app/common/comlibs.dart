import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

class Comlibs {
  static Future<Uint8List> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result?.files.first != null) {
      return result!.files.first.bytes!;
    } else {
      throw "Cancelled File Picker";
    }
  }

  static Future<List<Uint8List?>> pickMultiImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);
    List<Uint8List?> listImage = [];
    if (result != null && result.files.length > 0) {
      result.files.forEach((file) {
        listImage.add(file.bytes);
      });

      return listImage;
    } else {
      throw "Cancelled File Picker";
    }
  }
}

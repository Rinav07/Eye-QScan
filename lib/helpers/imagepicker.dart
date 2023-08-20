import 'package:image_picker/image_picker.dart';

import 'dart:io';
Future<dynamic> getimage() async {
  final ImagePicker picker = ImagePicker();

// Pick an image.
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);

  File _image = File(image!.path);

  return _image;
}


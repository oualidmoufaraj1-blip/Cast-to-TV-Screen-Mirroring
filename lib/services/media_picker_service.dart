import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MediaPickerService {
  MediaPickerService({ImagePicker? picker}) : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  Future<File?> pickPhoto(BuildContext context) async {
    final file = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 90,
    );
    if (file == null) return null;
    return File(file.path);
  }

  Future<File?> pickVideo(BuildContext context) async {
    final file = await _picker.pickVideo(
      source: ImageSource.gallery,
    );
    if (file == null) return null;
    return File(file.path);
  }
}

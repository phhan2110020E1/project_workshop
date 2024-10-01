// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_import, avoid_print

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async{
final ImagePicker _imagePicker = ImagePicker();
XFile? _file = await _imagePicker.pickImage(source: source);
if(_file != null){
  return await _file.readAsBytes();
}
print('No Images Selected');
}

Future<Uint8List?> pickVideo(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  final XFile? _file = await _imagePicker.pickVideo(source: source);

  if (_file != null) {
    return await _file.readAsBytes();
  }

  print('No Video Selected');
  return null; // Return null if no video is selected
}

class VideoSource {
}

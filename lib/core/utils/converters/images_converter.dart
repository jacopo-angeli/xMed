import 'dart:convert';
import 'package:flutter/widgets.dart';

class ImageConverter {
  static Image b64toWidget(String base64String) {
    return Image.memory(base64Decode(base64String));
  }
}

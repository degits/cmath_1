import 'package:flutter/material.dart';

class QImage {
  static Widget getWidget({
    required String url, required String width, required String height}) { 
    return Image.network(
      url,
      width: double.parse(width),
      height: double.parse(height),
    );
  }
}
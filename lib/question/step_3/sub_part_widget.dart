import 'package:flutter/material.dart';

class SubPartWidget {
  static Widget getWidget({required String text}) { 
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold
      ),
    );
  }
}
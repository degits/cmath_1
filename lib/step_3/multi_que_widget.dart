import 'package:flutter/material.dart';

class QuestionNumber {
  static Widget getWidget({required String questionNumber}) { 
    return Text(
      questionNumber,
      style: TextStyle(
        fontSize: 34
      ),
    );
  }
}
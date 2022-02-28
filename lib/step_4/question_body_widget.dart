import 'package:cmath_1/step_1/_parser.dart';
import 'package:cmath_1/step_3/img_widgets.dart';
import 'package:cmath_1/step_3/multi_que_widget.dart';
import 'package:cmath_1/step_3/sentence_widget.dart';
import 'package:cmath_1/step_3/sub_part_widget.dart';
import 'package:flutter/material.dart';

class Question {
  static List<Widget> getWidget() {
    /*
    [
      {
        type: sentence, 
        content: [{tag-type: math, content: f(x)=x^{2}+p x+c }, {tag-type: math, content: m+c }, {tag-type: bold, content: පොදු }, {tag-type: word, content: මූලයක් }, {tag-type: word, content: ඇති }, {tag-type: word, content: බව }, {tag-type: word, content: දී }, {tag-type: word, content: ඇත.}]
      },
    ]
    */
    List questionLineList = Parser.getQuestionAsDataStructure();
    List<Widget> questionBody = [];

    for (int i = 0; i < questionLineList.length; i++) {
      Map item = questionLineList[i];
      if (item["type"] == "sentence") {
        //content: [{tag-type: math, content: f(x)=x^{2}+p x+c }, {tag-type: math, content: m+c }, {tag-type: bold, content: පොදු }, {tag-type: word, content: මූලයක් }, {tag-type: word, content: ඇති }, {tag-type: word, content: බව }, {tag-type: word, content: දී }, {tag-type: word, content: ඇත.}]
        questionBody.add(Sentence.getWidget(item["content"]));
      } else if (item["type"] == "image") {
        //content: {url: <url>http:/imageUrl, width: <width>200, height: <height>100}
        questionBody.add(QImage.getWidget(
          url: item["content"]["url"],
          width: item["content"]["width"],
          height: item["content"]["height"],
        ));
      } else if (item["type"] == "sub-part") {
        questionBody.add(SubPartWidget.getWidget(text: item["content"]));
      }else if (item["type"] == "question") {
        questionBody.add(QuestionNumber.getWidget(questionNumber: item["content"]));
      }
    }

    //print(Parser.getQuestionAsDataStructure());

    return questionBody;
  }
}
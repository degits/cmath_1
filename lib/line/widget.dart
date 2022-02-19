import 'package:flutter/material.dart';

import 'parser.dart';

class Line {
  static Widget toLineWidget(String line) {
    //line =
     //   "Hi <m>math1</m> word1 <m>second one is this</m> <c>code_1</c> word <b>bold</b> last.";
    List<Map> lineParts = Parser.run(line);

    List<WidgetSpan> singleLineWidgetList = [];
    for (int i = 0; i < lineParts.length; i++) {
      //if (lineParts[i]["tag-type"] == "word") {
      singleLineWidgetList.add(
        WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: Text(lineParts[i]["content"])),
      );
      print(lineParts[i]["content"]);
      //}
    }
    
    return Text.rich(
      TextSpan(
        children: singleLineWidgetList,
      ),
    );
  }
}

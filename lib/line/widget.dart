import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter/material.dart';

import 'parser.dart';

class Line {
  static Widget toLineWidget(String line) {
    //line =
    //   "Hi <m>math1</m> word1 <m>second one is this</m> <c>code_1</c> word <b>bold</b> last.";
    List<Map> lineParts = Parser.run(line);

    List<WidgetSpan> singleLineWidgetList = [];
    for (int i = 0; i < lineParts.length; i++) {
      if (lineParts[i]["tag-type"] == "code") {
        singleLineWidgetList.add(
          WidgetSpan(
              alignment: PlaceholderAlignment.baseline,
              baseline: TextBaseline.alphabetic,
              child: Text(
                lineParts[i]["content"],
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 18.0
                ),
              )),
        );
      } else if (lineParts[i]["tag-type"] == "math") {
        singleLineWidgetList.add(WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: Math.tex(
              lineParts[i]["content"],
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600
              ),
              // logicalPpi: MathOptions.defaultLogicalPpiFor(42),
            )));

        singleLineWidgetList.add(
          const WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: Text("  "),
              // logicalPpi: MathOptions.defaultLogicalPpiFor(42),
            )
        );
      }else if (lineParts[i]["tag-type"] == "bold") {
        singleLineWidgetList.add(WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: Text(
                lineParts[i]["content"],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0
                ),
              )));
      } else {
        singleLineWidgetList.add(
          WidgetSpan(
              alignment: PlaceholderAlignment.baseline,
              baseline: TextBaseline.alphabetic,
              child: Text(
                lineParts[i]["content"],
                style: const TextStyle(
                  fontSize: 18.0
                ),
              )),
        );
      }
    }

    return Text.rich(
      TextSpan(
        children: singleLineWidgetList,
      ),
    );
  }
}

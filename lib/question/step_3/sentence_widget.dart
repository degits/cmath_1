import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class Sentence {
  static Widget getWidget(List<Map> linePartsList) {

    List<WidgetSpan> singleLineWidgetList = [];
    for (int i = 0; i < linePartsList.length; i++) {
      if (linePartsList[i]["tag-type"] == "code") {
        singleLineWidgetList.add(
          WidgetSpan(
              alignment: PlaceholderAlignment.baseline,
              baseline: TextBaseline.alphabetic,
              child: Text(
                linePartsList[i]["content"],
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 18.0
                ),
              )),
        );
      } else if (linePartsList[i]["tag-type"] == "math") {
        singleLineWidgetList.add(WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: Math.tex(
              linePartsList[i]["content"],
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
      }else if (linePartsList[i]["tag-type"] == "bold") {
        singleLineWidgetList.add(WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: Text(
                linePartsList[i]["content"],
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
                linePartsList[i]["content"],
                style: const TextStyle(
                  fontSize: 18.0
                ),
              )),
        );
      }
    }

    return 
    Text.rich(
      TextSpan(
        children: singleLineWidgetList,
      ),
    );
  }
}

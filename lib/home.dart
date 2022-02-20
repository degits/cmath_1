import 'package:cmath_1/sample.dart';
import 'package:flutter/material.dart';

import 'line/widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<Widget> body = [];
    List<List<Map>> bodyForEncode = [];

    int startIndex = 0;
    int endIndex = 0;
    List<String> linesList = [];
    //!must be a callback
    String completeQuestion = fu();

    while (true) {
      //print(completeQuestion.indexOf("\n", startIndex));
      endIndex = completeQuestion.indexOf("\n", startIndex);
      if (endIndex != -1) {
        String line = completeQuestion.substring(startIndex, endIndex);
        //!This must needed for empty line
        if (line == "") {
          linesList.add(" ");
        } else {
          linesList.add(line);
        }

        startIndex = endIndex + 1;
      } else {
        break;
      }
    }
    //print("=================================");
    //print(linesList);

    for (int i = 0; i < linesList.length; i++) {
      body.add(Line.toLineWidget(linesList[i])['widget']);
      bodyForEncode.add(Line.toLineWidget(linesList[i])['list']);
    }
    print(bodyForEncode);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      //appBar: AppBar(),
      body: ListView(
        children: body,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}

import 'package:cmath_1/parser/parser_collection/img_parser.dart';
import 'package:cmath_1/parser/parser_collection/multi_que.dart';
import 'package:cmath_1/parser/parser_collection/sentence_parser.dart';
import 'package:cmath_1/parser/parser_collection/subparts.dart';
import 'package:cmath_1/parser/question.dart';

class Parser {
  static List<Map> getQuestionAsDataStructure() {
    //!must be a callable
    String completeQuestion = getReloadingString();

    List<String> lineList =
        convertStringToListOfLines(question: completeQuestion);

    List<Map> questionAsList = lineToParser(lineList);
    return questionAsList;
  }
}



List<String> convertStringToListOfLines({required String question}) {
  int startIndex = 0;
  int endIndex = 0;
  List<String> linesList = [];
  while (true) {
    //print(completeQuestion.indexOf("\n", startIndex));
    endIndex = question.indexOf("\n", startIndex);
    if (endIndex != -1) {
      String line = question.substring(startIndex, endIndex);
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
  return linesList;
}




List<Map> lineToParser(List<String> lineList) {

  List<Map> parsedCompleteQuestion = [];

  for (int i = 0; i < lineList.length; i++) {
    if (lineList[i].startsWith("->Img") || lineList[i].startsWith("->img")) {
      //call Img parser
      parsedCompleteQuestion.add(
        {
          "type" : "image",
          "content": ImageParser.run(lineList[i]),
        }  
      );
    } else if (lineList[i].startsWith("->sub-part") || lineList[i].startsWith("->subparts")) {
      //call SubPart parser
      parsedCompleteQuestion.add(
        {
          "type" : "sub-part",
          "content": SubPartParser.run(lineList[i]),
        }  
      );
    } else if (lineList[i].startsWith("->q") || lineList[i].startsWith("->question")) {
      //call Question parser
      parsedCompleteQuestion.add(
        {
          "type" : "question",
          "content": MultiQuestionParser.run(lineList[i]),
        }
      );
    } else {
      //call Sentence parser
      parsedCompleteQuestion.add(
        {
          "type" : "sentence",
          "content": SingleSentenceParser.run(lineList[i]),
        }
        
      );
    }
    //body.add(Line.toLineWidget(lineList[i])['widget']);
    //bodyForEncode.add(Line.toLineWidget(lineList[i])['list']);
  }

  return parsedCompleteQuestion;
}

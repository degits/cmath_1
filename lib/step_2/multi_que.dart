class MultiQuestionParser {

  /*
  return of run() :-
  
    "12"
  
   */
  static String run(String line) {
    String sub = line.substring(3, line.length);
    print(sub);
    if (sub.isEmpty || sub == " ") {
      throw "⚠️⚠️⚠️ multi_que_parser.dart , No question founded";
    }

    //return
    return sub;
  }
}
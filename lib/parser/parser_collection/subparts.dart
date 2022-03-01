class SubPartParser {

  /*
  return of run() :-
  
    "a"
  
   */
  static String run(String line) {
    String sub = line.substring(10, line.length);
    if (sub.isEmpty || sub == " ") {
      throw "⚠️⚠️⚠️ sub-part_parser.dart , No subpart letter founded";
    }

    //return
    return sub;
  }
}
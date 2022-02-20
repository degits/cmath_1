//1.split by " "(spaces)    !?split cannot be used
//if split used, end index cannot be get

class Parser {
  static List<Map> run(String line) {
    //String myLine =
    //   " Hi <m>math1</m> word1 <m>second one is this</m> <c>code_1</c> word <b>bold</b> last. ";
    //String line =
    //"||||||||||||||| word1 ||||||||||||||||||||||||| ||||||||||||| word ||||||||||| last.";

    Map tagParserOutput = tagParser(line: line);
    return parseWordsAndMakeFullLinePartList(tagParserReturn: tagParserOutput);
  }

  static List<Map> parseWordsAndMakeFullLinePartList({required Map tagParserReturn}) {
    //inputs
    String wordOnlyLine = tagParserReturn["word-only-line"];
    List contentList = tagParserReturn["content-list"];

    List<Map> lineParts = [];

    int subStringStartIndex = 0;
    int subStringEndIndex = wordOnlyLine.indexOf(" ");
    int index = 0;
    String subString = "";

    while (subStringEndIndex != -2) {
      //!=========================================================================
      if (lineParts.length == 0) {
        subString =
            wordOnlyLine.substring(subStringStartIndex, subStringEndIndex + 1);
        //print(subString);

        if (subString.startsWith("|")) {
          lineParts.add(contentList[index]);
          index++;
        } else {
          lineParts.add({
            "tag-type": "word",
            "content": subString,
          });
        }

        wordOnlyLine = wordOnlyLine.replaceRange(
            subStringEndIndex, subStringEndIndex + 1, "|");

        subStringStartIndex = subStringEndIndex;

        subStringEndIndex = wordOnlyLine.indexOf(" ");

        //!=========================================================================
      } else if (subStringEndIndex == -1) {
        subString = wordOnlyLine.substring(
            subStringStartIndex + 1, wordOnlyLine.length);
        //print(subString);

        if (subString.startsWith("|")) {
          lineParts.add(contentList[index]);
          index++;
        } else {
          lineParts.add({
            "tag-type": "word",
            "content": subString,
          });
        }

        subStringEndIndex = -2;
      }
      //!===========================================================================
      else {
        subString = wordOnlyLine.substring(
            subStringStartIndex + 1, subStringEndIndex + 1);
        //print(subString);

        if (subString.startsWith("|")) {
          lineParts.add(contentList[index]);
          index++;
        } else {
          lineParts.add({
            "tag-type": "word",
            "content": subString.toString(),
          });
        }

        wordOnlyLine = wordOnlyLine.replaceRange(
            subStringEndIndex, subStringEndIndex + 1, "|");

        subStringStartIndex = subStringEndIndex;

        subStringEndIndex = wordOnlyLine.indexOf(" ");
      }
    }

    //print(lineParts);
    return lineParts;
  }

//! finish (ok)
//!--------------------------------------------------------------------------------------------------------------------------------
  static Map<String, dynamic> tagParser({required String line}) {
    //-helper-
    const List<Map> tags = [
      //startTag & endTag should only have one letter only.
      //eg: with one letter -> last index = line.indexOf(tags[currentTag]["endTag"]) + 4;
      //    with two letter -> last index = line.indexOf(tags[currentTag]["endTag"]) + 5;
      {
        "startTag": "<m>",
        "endTag": "</m>",
      },
      {
        "startTag": "<c>",
        "endTag": "</c>",
      },
      {"startTag": "<b>", "endTag": "</b>"}
    ];

    //-output-
    List<Map<String, String>> tagContentList = [];

    int currentTag = 0;

    while (currentTag < tags.length) {
      int startIndex = line.indexOf(tags[currentTag]["startTag"]); // 3  - <
      // if indexOf does not match exact word, this method returns -1.
      if (startIndex != -1) {
        //  6 things happen when start index is not equal to -1

        //Find end Index
        int endIndex = line.indexOf(tags[currentTag]["endTag"]) + 4; // 11 -  <

        //Make substring without start & end tags
        String subStringWithoutTags =
            (line.substring(startIndex + 3, endIndex - 4)) +
                " "; // eg:-   math1

        //Make substring with start & end tags
        //This used to make replace string (eg: ||||||)
        String subStringWithTags =
            line.substring(startIndex, endIndex); // eg:-   <m>math1</m>

        if (subStringWithTags.startsWith("<m>")) {
          //Add SubString + startIndex to a list
          tagContentList.add({
            "tag-type": "math",
            "content": subStringWithoutTags,
          });
        } else if (subStringWithTags.startsWith("<c>")) {
          tagContentList.add({
            "tag-type": "code",
            "content": subStringWithoutTags,
          });
        } else if (subStringWithTags.startsWith("<b>")) {
          tagContentList.add({
            "tag-type": "bold",
            "content": subStringWithoutTags,
          });
        } else {
          print("⚠️⚠️⚠️Warning:-  Undefined tag parsed !!!");
        }

        //Make replace string
        String replaceString = "";
        for (int i = 0; i < subStringWithTags.length; i++) {
          replaceString = replaceString + "|";
        }
        //Replace substring with "|"
        line = line.replaceRange(startIndex, endIndex, replaceString);
        //print(replaceString.length); - 12

      } else {
        currentTag++;
      }
    }

    //print("line Parts: $tagContentList");
    //print(line);

    return {"content-list": tagContentList, "word-only-line": line};
  }
}


class ImageParser {

  /*
  return of run() :-

  
    {
      "url": "https:/url",
      "width": 200,
      "height": 400
    }
  
   */
  static Map run(String line) {
    Map imgDetails = {};

    //For url
    int startIndex = line.indexOf("<url>");
    if (startIndex == -1) {
      throw "⚠️⚠️⚠️ image_parser.dart , <url> tag not find";
    }
    int endIndex = line.lastIndexOf("</url>");
    if (startIndex == -1) {
      throw "⚠️⚠️⚠️ image_parser.dart , </url> tag not find";
    }
    imgDetails["url"] = line.substring(startIndex + 5, endIndex);

    //For width
    startIndex = line.indexOf("<width>");
    if (startIndex == -1) {
      throw "⚠️⚠️⚠️ image_parser.dart , <width> tag not find";
    }
    endIndex = line.lastIndexOf("</width>");
    if (startIndex == -1) {
      throw "⚠️⚠️⚠️ image_parser.dart , </width> tag not find";
    }
    imgDetails["width"] = line.substring(startIndex + 7, endIndex);

    //For height
    startIndex = line.indexOf("<height>");
    if (startIndex == -1) {
      throw "⚠️⚠️⚠️ image_parser.dart , <height> tag not find";
    }
    endIndex = line.lastIndexOf("</height>");
    if (startIndex == -1) {
      throw "⚠️⚠️⚠️ image_parser.dart , </height> tag not find";
    }
    imgDetails["height"] = line.substring(startIndex + 8, endIndex);

    //return
    return imgDetails;
  }
}
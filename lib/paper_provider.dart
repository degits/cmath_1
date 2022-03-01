import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Paper with ChangeNotifier{

  List paper = [];
  String status = "start";

  void add(List question) {
    paper.add(question);
    notifyListeners();
  }

  void export() async{
    status = "loading";
    notifyListeners();
    try {
      String json = await fetchPhotos(paper);
      status = json;
      notifyListeners();
    } catch (e){
      throw e;
    }
  }
}

Future fetchPhotos(List paper) async {
  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, paper);
}

// A function that converts a response body into a List<Photo>.
String parsePhotos(List question) {
  final parsed = jsonEncode(question);

  return parsed;
}
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:http_test_run/constants/strings.dart';

class API_Manager {
  void getNews() async {
    var client = http.Client();

    var response = await client.get(
      Uri.parse(Strings.news_url),
    );
    if (response.statusCode == 200) {
      var jsonString = response
          .body; //This is where we get the jSon. Now we need to convert the json into a model.
      var jsonMap = json.decode(jsonString);

      //var newsModel = NewsModel.fromJson(jsonMap);  >> newsmodel on jsonin class
    }
  }
}

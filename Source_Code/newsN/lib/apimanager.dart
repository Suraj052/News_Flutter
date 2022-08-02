import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsn/model.dart';


class API_Manager
{
  Future<NewsModel> getNews() async
  {
    var client = http.Client();
    var newsModel = null;

    var url = Uri.parse("https://newsapi.org/v2/everything?domains=wsj.com&apiKey=a92eb379f5fd4c0e87be9895192278ce");

    try
    {
      var response = await client.get(url);
      if(response.statusCode == 200)
        {
            var jsonString = response.body;
            var jsonMap = json.decode(jsonString);

            newsModel = NewsModel.fromJson(jsonMap);
        }
    }
    catch(Exception)
    {
      return newsModel;
    }
    return newsModel;
  }
}
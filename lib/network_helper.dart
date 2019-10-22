import 'dart:convert';
import 'package:http/http.dart';

class NetworkHelper {
  String url;
  String country;

  NetworkHelper({String generateUrl, String countryName}) {
    this.country = countryName;
    this.url =
    'https://newsapi.org/v2/top-headlines?country=$countryName&apiKey=74b6e32b552a4e47b44f4ce2df69e1dc';
  }

  Future<Map> fetchNewsMap() async {
    print('reached here inside fewtch');
    Response response = await get(url);
    if (response.statusCode == 200) {
      print("response 200");
    }
    Map newsMap = jsonDecode(response.body);
    print(newsMap['articles'][0]['title']);
    return newsMap;
  }
}



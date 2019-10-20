import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  String nationCode = 'us';
  List articles = [];
  String author;
  String title;
  String description;
  String image;
  String publishTime;
  String content;

  Future<void> getNews() async {
    Map jsonMap;
    Response response = await get(
        'https://newsapi.org/v2/top-headlines?country=$nationCode&apiKey=74b6e32b552a4e47b44f4ce2df69e1dc');
    print(response.statusCode);
    if (response.statusCode == 200) {
      jsonMap = await jsonDecode(response.body);
      setState(() {
        articles = jsonMap['articles'];
        for (Map x in articles) {
          author = x['0']['author'];
          title = x['0']['title'];
          description = x['0']['description'];
          image = x['0']['urlToImage'];
          publishTime = x['0']['publishedAt'];
          content =x['0']['content'];
        }
      });
    }
  }

  Widget NewsCard = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Text(
        'PM Modi seeks ideas for his IIT-Madras ',
        textAlign: TextAlign.left,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'PT_Serif',
          fontSize: 16,
        ),
        //
      ),
      Row(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Expanded(
              flex: 7,
              child: Container(
                child: Text(
                  '$description aa ',
                  style: TextStyle(),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: Image.network(
                '$image',
              ),
            ),
          ),
        ],
      ),
      Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              'Politics     8h Ago',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              width: 150,
              height: 3,
              color: Colors.white,
              child: Row(),
              //margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
            ),
          ),
          Expanded(
              flex: 2,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.share,
                      color: Colors.grey,
                      size: 15.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.bookmark_border,
                      color: Colors.grey,
                      size: 15.0,
                    ),
                  ),
                ],
              )),
          SizedBox(
            width: double.infinity,
            height: 10,
          )
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

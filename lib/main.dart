import 'package:flutter/material.dart';
import 'network_helper.dart';
import 'details_page.dart';

void main() => runApp(MaterialApp(
      home: NewsListPage(),
    ));

class NewsListPage extends StatefulWidget {
  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  Map newsMap;
  NetworkHelper networkCall = NetworkHelper(countryName: 'in');
  bool newsLoaded = true;

  void fetchNews() async {
    newsLoaded = false;
    print('entered FetchNews');
    newsMap = await networkCall.fetchNewsMap();
    newsLoaded = true;
    setState(() {});
  }

  @override
  void initState() {
    fetchNews();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Your Times',
            style: TextStyle(
                fontSize: 32, color: Colors.black, fontFamily: 'OldLondon'),
          ),
        ),
        body: RefreshIndicator(
          child: newsLoaded
              ? NewsCardList(newsLoaded, newsMap)
              : Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3.0,
                    backgroundColor: Colors.red,
                  ),
                ),
          onRefresh: () {
            print('refreshing');
            setState(() {
              fetchNews();
              print('refreshed');
            });
            dispose();
            print('disposed');
            return null;
          },
        ));
  }
}

class NewsCardList extends StatelessWidget {
  final bool fetchNews;
  final Map newsMap;

  NewsCardList(this.fetchNews, this.newsMap);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.push(
              (context),
              MaterialPageRoute(
                builder: (context) => DetailsPage(
                  descriptionFromHomePage: newsMap['articles'][index]
                      ['description'],
                  titleFromHomePage: newsMap['articles'][index]['title'],
                  urlFromHomePage: newsMap['articles'][index]['urlToImage'],
                  sourceFromHomePage: newsMap['articles'][index]['source']
                      ['name'],
                  timeFromHomePage:
                      DateTime.parse(newsMap['articles'][index]['publishedAt']),
                ),
              ),
            );
          },
          title: Container(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                //title
                Container(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      newsMap['articles'][index]['title'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          fontFamily: 'NotaSerif'),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        width: 250,
                        margin: EdgeInsets.all(2.0),
                        child: Center(
                          child:
                              newsMap['articles'][index]['description'] != null
                                  ? Text(
                                      newsMap['articles'][index]['description'],
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontFamily: 'NotaSerif'),
                                      maxLines: 4,
                                    )
                                  : Text('No description provided'),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: 150,
                        margin: EdgeInsets.all(2.0),
                        child: Hero(
                          tag: '${newsMap['articles'][index]['title']}',
                          child:
                              newsMap['articles'][index]['urlToImage'] == null
                                  ? Image.asset('assets/defaultimage.png')
                                  : Image.network(
                                      newsMap['articles'][index]['urlToImage'],
                                    ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                      newsMap['articles'][index]['source']
                                          ['name'],
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: 'NotaSerif')),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12),
                                    child: Text(
                                      '${DateTime.now().difference(DateTime.parse(newsMap['articles'][index]['publishedAt'])).inHours} hour(s) ago',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: 'NotaSerif'),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.all(2.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Icon(
                                      Icons.share,
                                      color: Colors.blueGrey,
                                    ),
                                    Icon(
                                      Icons.bookmark_border,
                                      color: Colors.blueGrey,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  color: Colors.black.withAlpha(200),
                  height: 2.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'image_page.dart';


class DetailsPage extends StatelessWidget {
  final String titleFromHomePage;
  final String descriptionFromHomePage;
  final String urlFromHomePage;
  final DateTime timeFromHomePage;
  final String sourceFromHomePage;

  DetailsPage({this.descriptionFromHomePage,this.timeFromHomePage, this.titleFromHomePage, this.urlFromHomePage, this.sourceFromHomePage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text('India',
        style: TextStyle(
          fontSize: 28,
            color: Colors.black
        ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
        ),
        actions: <Widget>[Icon(Icons.more_vert), Icon(Icons.share)],
      ),
      body: Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(titleFromHomePage,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
                fontFamily: 'NotaSerif'
              )),
          Center(
            child: descriptionFromHomePage != null
                ? Text(descriptionFromHomePage, style: TextStyle(
                fontFamily: 'NotaSerif'
            ),)
                : Text('No description provided'),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(
                (context),
                MaterialPageRoute(
                  builder: (context) => PhotoPage(
                    urlFromHomePage: urlFromHomePage,
                    titleFromHomePage: titleFromHomePage,
                  ),
                ),
              );
            },
            child: urlFromHomePage == null ? Image.asset(
              'assets/defaultimage.png',
              fit: BoxFit.cover,
            ) :
            Container(
              child : Image.network(urlFromHomePage, fit: BoxFit.cover,),
            ),
          ),
          Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
          Text("By $sourceFromHomePage",
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'NotaSerif')),
          Text(
            "${timeFromHomePage.day}-${timeFromHomePage.month}-${timeFromHomePage.year}",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontFamily: 'NotaSerif'),
          )
        ],
      ),
      ),
    );
  }
}
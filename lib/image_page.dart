import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoPage extends StatelessWidget {
  final urlFromHomePage;
  final titleFromHomePage;

  PhotoPage({this.urlFromHomePage, this.titleFromHomePage});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: PhotoView(
        imageProvider: NetworkImage(urlFromHomePage,),
      ),
    );
  }
}

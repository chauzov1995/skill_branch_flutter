import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:FlutterGalleryApp/res/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchScreenState();
  }
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<String> strings = [
    'avocado',
    'lime',
    'salt',
    'salt',
    'salt',
    'sour cream',
    'vinegar',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      Padding(
        padding: EdgeInsets.all(10),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                color: AppColors.mercury,
                child: TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.search),
                    border: InputBorder.none,
                    labelStyle: TextStyle(
                      color: AppColors.dodgerBlue,
                    ),
                    hintText: 'Search',
                  ),
                ))),
      ),
      Expanded(
          child: new Container(
        width: double.infinity,
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 3,
          itemCount: 118,
          itemBuilder: (BuildContext context, int index) => new Container(
              color: Colors.green,
              child: new Center(
                child: new CircleAvatar(
                  backgroundColor: Colors.white,
                  child: new Text('$index'),
                ),
              )),
          staggeredTileBuilder: (int index) {
            switch (index % 18) {
              case 0:
                return new StaggeredTile.count(2, 2);
                break;
              case 10:
                return new StaggeredTile.count(2, 2);
                break;
              default:
                return new StaggeredTile.count(1, 1);
                break;
            }
          },
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
      )),
    ])));
  }

  Widget captionText(String titleText, String subText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  titleText,
                  style: TextStyle(color: Colors.black, fontSize: 24.0),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  subText,
                  style: TextStyle(color: Colors.blueGrey, fontSize: 16.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget myPhotoList(String MyImages) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(MyImages),
        ),
      ),
    );
  }
}

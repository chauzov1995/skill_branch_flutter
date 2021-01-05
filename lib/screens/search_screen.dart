import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:FlutterGalleryApp/res/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchScreenState();
  }
}

class _SearchScreenState extends State<SearchScreen>
   {


  @override
  void initState() {

    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:SafeArea(child:  Column(children: [
        Padding(padding: EdgeInsets.all(10),child:
        ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
                color: AppColors.mercury,
                child:
                    TextField(

          decoration: InputDecoration(
              icon: Icon(Icons.search),
              border: InputBorder.none,
              labelStyle: TextStyle(
                color: AppColors.dodgerBlue,
              ),
              hintText: 'Search',

          ),))),
        )
      ],),)
    );
  }
}

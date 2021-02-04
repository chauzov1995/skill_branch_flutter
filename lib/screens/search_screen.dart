import 'package:FlutterGalleryApp/data_provider.dart';
import 'package:FlutterGalleryApp/models/photo_list/model.dart';
import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:FlutterGalleryApp/res/styles.dart';
import 'package:FlutterGalleryApp/widgets/photoSearch.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
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

  final myController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  var data = List<Photo>();
  int pageCount = 0;

  @override
  void initState() {

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.8) {
        _getData(pageCount);
      }
    });
    print('set listener');

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    myController.dispose();
    super.dispose();
  }



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
                  controller: myController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.search),
                    border: InputBorder.none,
                    labelStyle: TextStyle(
                      color: AppColors.dodgerBlue,
                    ),
                    hintText: 'Search',
                  ),
                  textInputAction: TextInputAction.done,
                  onEditingComplete: (){
                    print("Second text field: ${myController.text}");
                    data.clear();
                    _getData(pageCount);
                  } ,
                ))),
      ),
      Expanded(
          child: new Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        child: StaggeredGridView.countBuilder(
          controller: _scrollController,
          crossAxisCount: 3,
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) =>
              PhotoViewSerach(
                    photoLink:  data[index].urls.small, placeholder: data[index].color,
                  ),

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
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
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


  void _getData(int page)async{

    PhotoList tempList = await DataProvider.searchPhotos(keyword: myController.text.trim(),page: page,page_size: 15);

      setState(() {

        data.addAll(tempList.photos.toList());
        pageCount++;
      });
    }

}

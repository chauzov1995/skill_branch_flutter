import 'package:FlutterGalleryApp/pages/webview_page.dart';
import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/screens/photo_screen.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:FlutterGalleryApp/data_provider.dart';
import 'package:FlutterGalleryApp/models/photo_list/model.dart';

import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  Feed({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FeedsState();
  }
}

class _FeedsState extends State<Feed> {
  ScrollController _scrollController = ScrollController();
  int pageCount = 1;
  bool isLoading = false;
  bool errorload = false;
  var data = List<Photo>();

  @override
  void initState() {
    this._getData(pageCount);
    print('load data');
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(child:  Hero(
      tag: 'tag',
      child: RefreshIndicator(

          onRefresh: () async {
            await _getData(0, cleardata: true);
          },
          child:   (errorload)  ?
         Card(
        margin: EdgeInsets.all(10),
        color: Colors.pink,
        child: ListTile(
        leading: Icon(
        Icons.warning_amber_outlined,
        color: Colors.white,
        ),
        title: Text(
        "There was an error loading the feed",
        style: AppStyles.h2Black.copyWith(
        fontWeight: FontWeight.w400, color: Colors.white),
        ),
        ),
        )
        : ListView.builder(
            shrinkWrap: true,
              controller: _scrollController,
              itemCount: data.length % 15 == 0 ? data.length + 1 : data.length,
              itemBuilder: (BuildContext context, int index) {


                if (index == data.length) {
                  return Container(
                      height: 400,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ));
                }

                return Column(
                  children: [
                    _buildItem(data[index]),
                    Divider(
                      thickness: 2,
                      color: AppColors.mercury,
                    ),
                  ],
                );
              })),
    ),));
  }

  Widget _buildItem(Photo photo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hero(
        //    tag: 'tag',
        //   child:
        GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/fullScreenImage',
                  arguments: FullScreenImageArguments(
                      photo: photo,
                      heroTag: 'tag',
                      routeSettings: RouteSettings(arguments: 'Some title')));
            },
            child: PhotoView(
              photoLink: photo.urls.regular,
              placeholder: photo.color,
            )),
        //  ),
        _buildPhotoMeta(photo),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            photo.description ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.h3.copyWith(color: AppColors.black),
          ),
        )
      ],
    );
  }

  Widget _buildPhotoMeta(Photo photo) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/fullScreenImage',
                  arguments: FullScreenImageArguments(
                      photo: photo,
                      heroTag: 'tag',
                      routeSettings: RouteSettings(arguments: 'Some title')));
            },
            child: Row(
              children: [
                UserAvatar(photo.user.profileImage.large),
                SizedBox(
                  width: 6,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(photo.user.name, style: AppStyles.h2Black),
                    Text(
                      '@${photo.user.username}',
                      style:
                          AppStyles.h5Black.copyWith(color: AppColors.manatee),
                    )
                  ],
                )
              ],
            ),
          ),
          LikeButton(photo),
        ],
      ),
    );
  }

  void _getData(int page, {bool cleardata = false}) async {
    try {
     //throw ("some arbitrary error");
setState(() {
  errorload = false;
});
      if (cleardata) {
        data.clear();
      }

      if (!isLoading) {
        setState(() {
          isLoading = true;
        });
        var tempList = await DataProvider.getPhotos(page, 15);

        setState(() {
          isLoading = false;
          data.addAll(tempList.photos);
          pageCount++;
          print('pageCount${pageCount}');
        });
      }
    } catch (extensions) {
      setState(() {
        errorload = true;
      });
    }
  }
}

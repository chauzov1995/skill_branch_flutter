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
  int pageCount = 0;
  bool isLoading = false;
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
      body:

      DataProvider.authToken == ""?  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Press button to login',
            ),
            Container(
              width: 100,
              child: FlatButton(
                child: Text("Login"),
                color: Colors.blue,
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                onPressed: () => doLogin(context),
              ),
            ),
          ],
        ),
      ):Hero(
          tag: 'tag',
          child: ListView.builder(

              controller: _scrollController,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                if (index == data.length) {
                  return Center(
                    child: Opacity(
                      opacity: isLoading ? 1 : 0,
                      child: CircularProgressIndicator(),
                    ),
                  );
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
    );
  }

  Widget _buildItem(Photo photo) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/fullScreenImage',arguments: FullScreenImageArguments(
            photo:  photo.urls.regular,
            altDescription: photo.description,
            userName: photo.user.username,
            name: photo.user.name,
            userPhoto:  photo.user.profileImage.large,
            heroTag: 'tag',
            routeSettings: RouteSettings(arguments: 'Some title')
          ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero(
          //    tag: 'tag',
          //   child:
          PhotoView(
            photoLink:  photo.urls.regular,
          ),
          //  ),
          _buildPhotoMeta(photo),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              photo.description??'',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.h3.copyWith(color: AppColors.black),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPhotoMeta(Photo photo) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              UserAvatar('https://skill-branch.ru/img/speakers/Adechenko.jpg'),
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
                    style: AppStyles.h5Black.copyWith(color: AppColors.manatee),
                  )
                ],
              )
            ],
          ),
          LikeButton(photo.likes, photo.likedByUser),
        ],
      ),
    );
  }

  void doLogin(BuildContext context) {
    if (DataProvider.authToken == "") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WebViewPage()),
      ).then((value) {
        RegExp exp = RegExp("(?<==).*");
        var oneTimeCode = exp.stringMatch(value);

        DataProvider.doLogin(oneTimeCode: oneTimeCode).then((value) {
          DataProvider.authToken = value.accessToken;


        });
      });
    }
  }
  void _getData(int page) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      var tempList = await DataProvider.getPhotos(page, 15);
print("asdasdadada ${tempList.photos.length}");
      setState(() {
        isLoading = false;
        data.addAll(tempList.photos);
        pageCount++;
      });
    }
  }
}

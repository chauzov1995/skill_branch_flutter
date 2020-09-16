import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/screens/photo_screen.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';

import 'package:flutter/material.dart';

const String kFlutterDash =
    'https://miro.medium.com/max/512/1*6Xz5i8qL9eu8RVISKIMZKQ.png';

class Feed extends StatefulWidget {
  Feed({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FeedsState();
  }
}

class _FeedsState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
          tag: 'tag',
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    _buildItem(),
                    Divider(
                      thickness: 2,
                      color: AppColors.mercury,
                    ),
                  ],
                );
              })),
    );
  }

  Widget _buildItem() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return FullScreenImage(
            photo: kFlutterDash,
            altDescription: 'This is Flutter dash. I love him :)',
            userName: 'kaparray',
            name: 'Kirill Adeshchenko',
            userPhoto: 'https://skill-branch.ru/img/speakers/Adechenko.jpg',
            heroTag: 'tag',
          );
        }));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero(
          //    tag: 'tag',
          //   child:
          Photo(
            photoLink: kFlutterDash,
          ),
          //  ),
          _buildPhotoMeta(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              'This is Flutter Dash. I love him',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.h3.copyWith(color: AppColors.black),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPhotoMeta() {
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
                  Text('Никита Чаузов', style: AppStyles.h2Black),
                  Text(
                    '@kaparray',
                    style: AppStyles.h5Black.copyWith(color: AppColors.manatee),
                  )
                ],
              )
            ],
          ),
          LikeButton(10, true),
        ],
      ),
    );
  }
}

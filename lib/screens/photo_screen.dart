import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:FlutterGalleryApp/res/styles.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String kFLutterDash =
    'https://miro.medium.com/max/512/1*6Xz5i8qL9eu8RVISKIMZKQ.png';

class FullScreenImage extends StatefulWidget {
  FullScreenImage(
      {this.userName,
      this.altDescription,
      this.name,
      Key key,
      this.photo,
      this.userPhoto,
      this.heroTag})
      : super(key: key);

  final String userName;
  final String altDescription;
  final String name;
  final String photo;
  final String userPhoto;
  final String heroTag;

  @override
  State<StatefulWidget> createState() {
    return _FullScreenImageState();
  }
}

class _FullScreenImageState extends State<FullScreenImage> {
  String userName;
  String altDescription;
  String name;
  String heroTag;

  @override
  void initState() {
    super.initState();
    userName = widget.userName;
    altDescription = widget.altDescription;
    name = widget.name;
    heroTag = widget.heroTag;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo'),
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () {},
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: heroTag,
            child: Photo(
              photoLink: kFLutterDash,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              altDescription.toString(),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.h3.copyWith(color: AppColors.black),
            ),
          ),
          _buildPhotoMeta(),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LikeButton(2157, true),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => true,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Container(
                            height: 36,
                            width: 105,
                            color: AppColors.dodgerBlue,
                            child: Center(
                              child: Text(
                                'Save',
                                style: AppStyles.h3,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      GestureDetector(
                        onTap: () => true,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Container(
                            height: 36,
                            width: 105,
                            color: AppColors.dodgerBlue,
                            child: Center(
                              child: Text(
                                'Visit',
                                style: AppStyles.h3,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }

  Widget _buildPhotoMeta() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          UserAvatar('https://skill-branch.ru/img/speakers/Adechenko.jpg'),
          SizedBox(
            width: 6,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name.toString(), style: AppStyles.h1Black),
              Text(
                '@$userName',
                style: AppStyles.h5Black.copyWith(color: AppColors.manatee),
              )
            ],
          )
        ],
      ),
    );
  }
}

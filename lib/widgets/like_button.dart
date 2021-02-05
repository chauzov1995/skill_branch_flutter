import 'package:FlutterGalleryApp/data_provider.dart';
import 'package:FlutterGalleryApp/models/photo_list/model.dart';
import 'package:FlutterGalleryApp/res/app_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:FlutterGalleryApp/res/colors.dart';

class LikeButton extends StatefulWidget {
  LikeButton(
    this.photo,
     {
    Key key,
  }) : super(key: key);

  final Photo photo;


  @override
  State<StatefulWidget> createState() {
    return _LikeButtonState();
  }
}

class _LikeButtonState extends State<LikeButton> {
  bool isLiked;
  int likeCount;
  @override
  void initState() {
  
    super.initState();
    isLiked = widget.photo.likedByUser;
    likeCount = widget.photo.likes;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {

          isLiked = !isLiked;
          widget.photo.likedByUser=isLiked;

          if (isLiked) {
            likeCount++;

            DataProvider.likePhoto(widget.photo.id);

          } else {
            likeCount--;

            DataProvider.unlikePhoto(widget.photo.id);
          }
          widget.photo.likes=likeCount;
        });
      },
      child: Center(
        child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(mainAxisSize: MainAxisSize.min,
              children: [
                Icon(isLiked ? AppIcons.like_fill : AppIcons.like, color: isLiked ?AppColors.dodgerBlue:AppColors.black),
                SizedBox(
                  width: 4.21,
                ),
                Text(likeCount.toString(),style: TextStyle(color: isLiked ?AppColors.dodgerBlue:AppColors.black ),)
              ],
            )),
      ),
    );
  }
}

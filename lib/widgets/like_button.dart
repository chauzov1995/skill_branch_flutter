import 'package:FlutterGalleryApp/res/app_icons.dart';
import 'package:flutter/cupertino.dart';

class LikeButton extends StatefulWidget {
  LikeButton(
    this.likeCount,
    this.isLiked, {
    Key key,
  }) : super(key: key);

  final int likeCount;
  final bool isLiked;

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
    // TODO: implement initState
    super.initState();
    isLiked = widget.isLiked;
    likeCount = widget.likeCount;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          isLiked = !isLiked;
          if (isLiked) {
            likeCount++;
          } else {
            likeCount--;
          }
        });
      },
      child: Center(
        child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Icon(isLiked ? AppIcons.like_fill : AppIcons.like),
                SizedBox(
                  width: 4.21,
                ),
                Text(likeCount.toString())
              ],
            )),
      ),
    );
  }
}

import 'package:FlutterGalleryApp/res/HexColor.dart';
import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PhotoView extends StatelessWidget {
  PhotoView({Key key, this.photoLink, this.placeholder="#ffffff",  this.height=1,  this.width=1}) : super(key: key);

  final String photoLink;
  final String placeholder;
  final int height;
  final int width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(17)),
        child: Container(
          color: AppColors.grayChateau,
          child: AspectRatio(aspectRatio: width/height,
          child:  CachedNetworkImage(
            imageUrl: photoLink,
            placeholder: (context, url) => Container(color: HexColor(placeholder),),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
          ),),
        ),
      ),
    );
  }
}

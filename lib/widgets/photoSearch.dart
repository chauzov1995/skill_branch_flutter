import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PhotoViewSerach extends StatelessWidget {
  PhotoViewSerach({Key key, this.photoLink, this.placeholder}) : super(key: key);

  final String photoLink;
  final String placeholder;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(17)),
        child: Container(
          color: AppColors.grayChateau,
          child: AspectRatio(aspectRatio: 1,
          child:  CachedNetworkImage(
            imageUrl: photoLink,
            placeholder: (context, url) => Container(color: Colors.red,),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
          ),),
        ),

    );
  }
}

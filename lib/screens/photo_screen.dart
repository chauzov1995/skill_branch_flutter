import 'package:FlutterGalleryApp/models/photo_list/model.dart';
import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:FlutterGalleryApp/res/styles.dart';
import 'package:FlutterGalleryApp/widgets/claim_bottom_sheet.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:gallery_saver/gallery_saver.dart';


class FullScreenImageArguments {
  FullScreenImageArguments({
    this.photo,
    this.key,
    this.heroTag,
    this.routeSettings,
  });

  final Photo photo;
  final Key key;
  final String heroTag;
  final RouteSettings routeSettings;
}

class FullScreenImage extends StatefulWidget {
  FullScreenImage({Key key, this.photo, this.heroTag}) : super(key: key);

  final Photo photo;

  final String heroTag;

  @override
  State<StatefulWidget> createState() {
    return _FullScreenImageState();
  }
}

class _FullScreenImageState extends State<FullScreenImage>
    with TickerProviderStateMixin {
  String userName;
  String altDescription;
  String name;
  String heroTag;
  AnimationController _controller;
  Animation<double> _first_anim;
  Animation<double> _second_anim;

  @override
  void initState() {
    super.initState();

    heroTag = widget.heroTag;

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..forward();

    _first_anim = Tween<double>(begin: 0, end: 1.0).animate(CurvedAnimation(
        parent: _controller, curve: Interval(0.0, 0.5, curve: Curves.ease)));
    _second_anim = Tween<double>(begin: 0, end: 1.0).animate(CurvedAnimation(
        parent: _controller, curve: Interval(0.5, 1.0, curve: Curves.ease)));

    // _controller = Tween(begin: 0.5, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  AppBar _buildAppBar() {
//String title=ModalRoute.of(context).settings.arguments;
    return AppBar(
      actions: [
        ClaimBottomSheet()
        /*
        IconButton(
          icon: Icon(
            Icons.more_vert,
            color: AppColors.grayChateau,
          ),
          onPressed: () {


            showModalBottomSheet(
              shape: RoundedRectangleBorder(  borderRadius: BorderRadius.circular(100)),
                context: context,
                builder: (context) {
                  return ClipRRect(
               //     borderRadius: BorderRadius.circular(100),
                    child:  Container(
                    decoration: BoxDecoration(
                      color: AppColors.mercury,

                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(10, (index) => FlutterLogo()),
                    ),
                   ) );
                });

          },
        )   */
      ],
      elevation: 0,
      title: Text(
        'Photo',
        style: AppStyles.h2Black,
      ),
      leading: IconButton(
        icon: Icon(
          CupertinoIcons.back,
          color: AppColors.grayChateau,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      backgroundColor: AppColors.white,
      centerTitle: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: heroTag,
            child: PhotoView(
              photoLink: widget.photo.urls.regular,
              //  placeholder: kFLutterDash.,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: widget.photo.description==null?Container(): Text(
              '${widget.photo.description}',
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
                  // LikeButton(2157, true),
                  SizedBox(width: 14),
                  Expanded(child: LikeButton(widget.photo)),
                  Expanded(
                      child: _buildButton('Save', () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text('download photos'),
                              content: Text(
                                  'Are you sure you want to download a photo?'),
                              actions: [
                                FlatButton(
                                  child: Text('Download'),
                                  onPressed: () {
                                    GallerySaver.saveImage(
                                        'https://skill-branch.ru/img/speakers/Adechenko.jpg');
                                    Navigator.of(context).pop();
                                  },
                                ),
                                FlatButton(
                                  child: Text('Close'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            ));
                  })),
                  SizedBox(width: 12),
                  Expanded(
                      child: _buildButton('Visit', () async {
                    OverlayState overlayState = Overlay.of(context);

                    OverlayEntry overlayEndtry =
                        OverlayEntry(builder: (BuildContext context) {
                      return Positioned(
                        top: MediaQuery.of(context).viewInsets.top + 50,
                        child: Material(
                          color: Colors.transparent,
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                                decoration: BoxDecoration(
                                    color: AppColors.mercury,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Text('Skillbranch')),
                          ),
                        ),
                      );
                    });

                    overlayState.insert(overlayEndtry);
                    await Future.delayed(Duration(seconds: 1));
                    overlayEndtry.remove();
                  })),
                ],
              ))
        ],
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback callback) {
    return GestureDetector(
      onTap: callback,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Container(
          height: 36,
          width: 105,
          color: AppColors.dodgerBlue,
          child: Center(
            child: Text(
              text,
              style: AppStyles.h3.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoMeta() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          AnimatedBuilder(
            animation: _first_anim,
            builder: (BuildContext context, Widget child) {
              return Opacity(
                opacity: _first_anim.value,
                child: UserAvatar(
                   widget.photo.user.profileImage.large),
              );
            },
          ),
          SizedBox(
            width: 6,
          ),
          AnimatedBuilder(
              animation: _second_anim,
              builder: (BuildContext context, Widget child) {
                return Opacity(
                    opacity: _second_anim.value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${widget.photo.user.name}', style: AppStyles.h1Black),
                        Text(
                          '@${widget.photo.user.username}',
                          style: AppStyles.h5Black
                              .copyWith(color: AppColors.manatee),
                        )
                      ],
                    ));
              })
        ],
      ),
    );
  }
}

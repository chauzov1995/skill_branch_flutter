import 'dart:io';

import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/screens/photo_screen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'screens/home.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (RouteSettings setting){
        if(setting.name=='/fullScreenImage'){
FullScreenImageArguments args= (setting.arguments as FullScreenImageArguments);
final route = FullScreenImage(
userName: args.userName,
altDescription: args.altDescription,
name: args.name,
key: args.key,
photo: args.photo,
userPhoto: args.userPhoto,
heroTag: args.heroTag,


);
if(Platform.isAndroid){
return MaterialPageRoute(builder: (context)=>route, settings: args.routeSettings);
}else if(Platform.isIOS){
  return CupertinoPageRoute(builder: (context)=>route, settings: args.routeSettings);
}
        }
      },
      home: Home(Connectivity().onConnectivityChanged),
    );
  }
}
class ConnectivityOverlay {
  static final ConnectivityOverlay _singleton = ConnectivityOverlay._internal();

  factory ConnectivityOverlay() {
    return _singleton;
  }

  ConnectivityOverlay._internal();

  static OverlayEntry overlayEntry;

  

void showOverlay(BuildContext context, Widget child)  {
 // реализуйте отображение Overlay.



 OverlayState overlayState = Overlay.of(context);

 overlayEntry=OverlayEntry(builder: (BuildContext context){
return Positioned(
  top: MediaQuery.of(context).viewInsets.top+50,
  child: Material(color: Colors.transparent,child: Container(
  alignment: Alignment.center,
  width: MediaQuery.of(context).size.width,
  child: Container(
    margin: EdgeInsets.symmetric(horizontal: 20),
    padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
    decoration: BoxDecoration(
      color: AppColors.mercury,
      borderRadius: BorderRadius.circular(12)
    ),
    child: Text('No internet connection')
  ),
),)

,);
});

overlayState.insert(overlayEntry);
//await Future.delayed(Duration(seconds: 1));


  }

  void removeOverlay(BuildContext context) {
// реализуйте удаление Overlay.

overlayEntry.remove();
  }
}

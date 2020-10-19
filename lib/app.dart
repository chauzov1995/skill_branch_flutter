import 'dart:io';

import 'package:FlutterGalleryApp/screens/photo_screen.dart';
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
      home: Home(),
    );
  }
}

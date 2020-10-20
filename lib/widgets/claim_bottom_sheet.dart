import 'package:FlutterGalleryApp/res/res.dart';
import 'package:flutter/material.dart';


class ClaimBottomSheet extends StatelessWidget  {

var list= [ 'adult', 'harm', 'bully', 'spam', 'copyright', 'hate'];


  @override
  Widget build(BuildContext context) {
    
    return
     IconButton(
          icon: Icon(
            Icons.more_vert,
            color: AppColors.grayChateau,
          ),
          onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                    decoration: BoxDecoration(
                   color: AppColors.white,
                    
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(list.length, (index) => InkWell(
                        
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                      //    padding:EdgeInsets.symmetric(vertical: 20),
                          child: Text(list[index].toUpperCase(),style: Theme.of(context).textTheme.headline6,)), ) ),
                    ),
                   ));
              },
            
          
    );
   
  }



}
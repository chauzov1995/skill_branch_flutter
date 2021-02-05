import 'package:FlutterGalleryApp/data_provider.dart';
import 'package:FlutterGalleryApp/res/app_icons.dart';
import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:FlutterGalleryApp/res/readMoreText.dart';
import 'package:FlutterGalleryApp/res/styles.dart';
import 'package:FlutterGalleryApp/widgets/photoSearch.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          PopupMenuButton(itemBuilder: (BuildContext context) {
            return [PopupMenuItem(child: Text('Logout'),value: 'Logout',)];
          }
          ,onSelected: (sele) async {
            if(sele=="Logout")
            print(DataProvider.authToken);
            DataProvider.myprofile= await DataProvider.getProfile();
            setState(() {

            });
            },
          )
        ],
        elevation: 0,
        title: Text(
          'Profile',
          style: AppStyles.h2Black,
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: CachedNetworkImage(
                    imageUrl:
                    DataProvider.myprofile.profileImage.large,
                    width: 75,
                    height: 75,
                    fit: BoxFit.fill,
                  ),
                )),
                SizedBox(
                  width: 18,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DataProvider.myprofile.name,
                      style: AppStyles.h2Black
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Row(
                          children: [
                            Text(
                              '${DataProvider.myprofile.followersCount}',
                              style: AppStyles.h1Black.copyWith(
                                  color: AppColors.dodgerBlue,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'followers',
                              style: AppStyles.h5Black,
                            ),
                          ],
                        )),
                        Expanded(
                          child: Row(children: [
                            Text(
                              '${DataProvider.myprofile.followingCount}',
                              style: AppStyles.h1Black.copyWith(
                                  color: AppColors.dodgerBlue,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'following',
                              style: AppStyles.h5Black,
                            ),
                          ]),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: AppColors.dodgerBlue,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          '${DataProvider.myprofile.location}',
                          style: AppStyles.h5Black,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.link_sharp,
                          color: AppColors.dodgerBlue,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          '${DataProvider.myprofile.portfolioUrl}',
                          style: AppStyles.h5Black,
                        )
                      ],
                    )
                  ],
                ))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child:
            ReadMoreText(

              '${DataProvider.myprofile.bio}',  style:AppStyles.h2Black.copyWith(fontWeight: FontWeight.w300,fontSize: 16), trimLines: 3,
              colorClickableText: Colors.black,
              trimMode: TrimMode.Line,
              trimCollapsedText: 'show more',
              trimExpandedText: ' close',
            ),


            ),

          TabBar(
            labelColor: AppColors.dodgerBlue,
            indicatorColor: AppColors.dodgerBlue,
            unselectedLabelColor: AppColors.black,
            controller: _tabController,
            tabs: [
              Tab(icon: Icon(Icons.home_outlined)),
              Tab(icon: Icon(AppIcons.like)),
              Tab(icon: Icon(Icons.wifi_outlined)),
            ],
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          Expanded(
              child: TabBarView(
            controller: _tabController,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: 21, left: 10, right: 10, bottom: 0),
                child: GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  children: [
                    PhotoViewSerach(
                      photoLink:
                          "https://miro.medium.com/max/2440/1*qnvChEMO0nWXAkajJgqDOQ.png",
                      placeholder: "#ffffff",
                    )
                  ],
                ),
              ),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ))
        ],
      ),
    );
  }
}

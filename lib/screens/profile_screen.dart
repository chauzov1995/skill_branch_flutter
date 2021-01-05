import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:FlutterGalleryApp/res/styles.dart';
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
      appBar: AppBar(
        actions: [
          // ClaimBottomSheet()
        ],
        elevation: 0,
        title: Text(
          'Profile',
          style: AppStyles.h2Black,
        ),
        backgroundColor: AppColors.white,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                    child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://miro.medium.com/max/512/1*6Xz5i8qL9eu8RVISKIMZKQ.png',
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
                      "Dannie Milohin",
                      style: AppStyles.h2Black.copyWith(fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Row(
                          children: [
                            Text(
                              '2665',
                              style: AppStyles.h1Black
                                  .copyWith(color: AppColors.dodgerBlue, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('followers',
                              style: AppStyles.h5Black,),
                          ],
                        )),
                        Expanded(
                          child: Row(children: [
                            Text(
                              '2665',
                              style: AppStyles.h1Black
                                  .copyWith(color: AppColors.dodgerBlue, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('following',
                              style: AppStyles.h5Black,),
                          ]),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: AppColors.dodgerBlue,
                        ),
                        Text('144 West market, Bloss, sddk',
                          style: AppStyles.h5Black,)
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.link_sharp,
                          color: AppColors.dodgerBlue,
                        ),
                        Text('www.leningrad.ru',
                          style: AppStyles.h5Black,)
                      ],
                    )
                  ],
                ))
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(10),child:
          Text('Opisanie asds asdas sdsds'),),
          TabBar(
            labelColor: AppColors.dodgerBlue,
            indicatorColor: AppColors.dodgerBlue,
            unselectedLabelColor: AppColors.black,
            controller: _tabController,
            tabs: [
              Tab(icon: Icon(Icons.home_outlined)),
              Tab(icon: Icon(Icons.linked_camera)),
              Tab(icon: Icon(Icons.wifi_outlined)),
            ],
          ),
          Divider(height: 1,thickness: 1,),
          Expanded(
              child: TabBarView(
            controller: _tabController,
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ))
        ],
      ),
    );
  }
}

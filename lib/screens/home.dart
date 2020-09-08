import 'package:flutter/material.dart';
import 'package:FlutterGalleryApp/res/res.dart';

import 'feed_screen.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int currentTab = 0;
  final PageStorageBucket bucket = PageStorageBucket();

  List<Widget> pages = [
    Feed(key: PageStorageKey('FeedPage')),
    Container(),
    Container()
  ];

  final List<BottomNavyBarItem> _tabs = [
    BottomNavyBarItem(
      asset: AppIcons.home,
      title: Text('Feed'),
      activeColor: AppColors.dodgerBlue,
      inactiveColor: AppColors.manatee,
    ),
    BottomNavyBarItem(
      asset: AppIcons.home,
      title: Text('Search'),
      activeColor: AppColors.dodgerBlue,
      inactiveColor: AppColors.manatee,
    ),
    BottomNavyBarItem(
      asset: AppIcons.home,
      title: Text('User'),
      activeColor: AppColors.dodgerBlue,
      inactiveColor: AppColors.manatee,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavyBar(
        showElevation: true,
        itemCornderRadious: 8,
        curve: Curves.ease,
        currentTab: currentTab,
        onItemSelected: (int index) {
          setState(() {
            currentTab = index;
          });
        },
        items: _tabs,
      ),
      body: PageStorage(bucket: bucket, child: pages[currentTab]),
    );
  }
}

class BottomNavyBar extends StatelessWidget {
  BottomNavyBar({
    Key key,
    this.currentTab,
    this.showElevation = true,
    this.backgroundColor, //= Colors.white,
    this.itemCornderRadious = 50,
    this.containerHeight = 56,
    this.animationDuration = const Duration(microseconds: 270),
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    @required this.items,
    @required this.onItemSelected,
    this.curve = Curves.linear,
  }) {
    assert(items != null);
    assert(items.length >= 2 && items.length <= 5);
    assert(onItemSelected != null);
    assert(curve != null);
  }

  final Color backgroundColor;
  final bool showElevation;
  final double containerHeight;
  final MainAxisAlignment mainAxisAlignment;
  final List<BottomNavyBarItem> items;
  final ValueChanged<int> onItemSelected;
  final int currentTab;
  final Duration animationDuration;
  final double itemCornderRadious;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final bgColor = (backgroundColor == null)
        ? Theme.of(context).bottomAppBarColor
        : backgroundColor;

    return Container(
      decoration: BoxDecoration(color: bgColor, boxShadow: [
        if (showElevation) const BoxShadow(color: Colors.black12, blurRadius: 2)
      ]),
      child: SafeArea(
          child: Container(
        width: double.infinity,
        height: containerHeight,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          children: items.map((item) {
            var index = items.indexOf(item);
            return GestureDetector(
              onTap: () => onItemSelected(index),
              child: _ItemWidget(
                curve: curve,
                animationDuration: animationDuration,
                backgroundColor: bgColor,
                isSelected: currentTab == index ? true : false,
                item: item,
                itemCornderRadious: itemCornderRadious,
              ),
            );
          }).toList(),
        ),
      )),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  _ItemWidget(
      {@required this.isSelected,
      @required this.item,
      @required this.backgroundColor,
      @required this.animationDuration,
      this.curve = Curves.linear,
      @required this.itemCornderRadious})
      : assert(animationDuration != null, 'animationDuration is null'),
        assert(curve != null, 'curve is null'),
        assert(isSelected != null, 'isSelected is null'),
        assert(item != null, 'item is null'),
        assert(backgroundColor != null, 'backgroundColor is null'),
        assert(itemCornderRadious != null, 'itemCornderRadious is null');
  final bool isSelected;
  final BottomNavyBarItem item;
  final Color backgroundColor;
  final Duration animationDuration;
  final Curve curve;
  final double itemCornderRadious;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: isSelected
          ? 150
          : (MediaQuery.of(context).size.width - 150 - 8 * 4 - 4 * 2) / 2,
      height: double.maxFinite,
      duration: animationDuration,
      // padding: const EdgeInsets.symmetric(horizontal: 5),

      curve: curve,
      decoration: BoxDecoration(
          color:
              isSelected ? item.activeColor.withOpacity(0.2) : backgroundColor,
          borderRadius: BorderRadius.circular(itemCornderRadious)),
      child: Container(
        width: isSelected
            ? 150
            : (MediaQuery.of(context).size.width - 150 - 8 * 4 - 4 * 2) / 2,
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              item.asset,
              size: 20,
              color: isSelected ? item.activeColor : item.inactiveColor,
            ),
            SizedBox(
              width: 4,
            ),
            Expanded(
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: DefaultTextStyle.merge(
                  child: item.title,
                  textAlign: item.textAlign,
                  style: TextStyle(
                      color: isSelected ? item.activeColor : item.inactiveColor,
                      fontWeight: FontWeight.bold),
                  maxLines: 1),
            ))
          ],
        ),
      ),
    );
  }
}

class BottomNavyBarItem {
  BottomNavyBarItem(
      {@required this.asset,
      @required this.title,
      this.activeColor = Colors.blue,
      this.inactiveColor,
      this.textAlign}) {
    assert(asset != null, 'Asset is null');
    assert(title != null, 'Asset is null');
  }
  final IconData asset;
  final Text title;
  final Color activeColor;
  final Color inactiveColor;
  final TextAlign textAlign;
}

import 'package:flutter/cupertino.dart';
import 'package:multi_store_app/widgets/repated_tab.dart';

import '../utilities/categ_list.dart';

class Tabs {
  final bool isRotated;
  Tabs({required this.isRotated});

  List<Widget> getTabs() {
    List<Widget> tabs = [
      RepeatedTab(
        isRotated: isRotated,
        tabName: maincateg[0],
        icon: CupertinoIcons.person,
      ),
      RepeatedTab(
        isRotated: isRotated,
        tabName: maincateg[1],
        icon: CupertinoIcons.person_2,
      ),
      RepeatedTab(
        isRotated: isRotated,
        tabName: maincateg[2],
        icon: CupertinoIcons.desktopcomputer,
      ),
      RepeatedTab(
        isRotated: isRotated,
        tabName: maincateg[3],
        icon: CupertinoIcons.person_3,
      ),
      RepeatedTab(
        isRotated: isRotated,
        tabName: maincateg[4],
        icon: CupertinoIcons.square_favorites_alt,
      ),
      RepeatedTab(
        isRotated: isRotated,
        tabName: maincateg[5],
        icon: CupertinoIcons.house_fill,
      ),
      RepeatedTab(
        isRotated: isRotated,
        tabName: maincateg[6],
        icon: CupertinoIcons.heart_fill,
      ),
      RepeatedTab(
        isRotated: isRotated,
        tabName: maincateg[7],
        icon: CupertinoIcons.person_2_fill,
      ),
      RepeatedTab(
        isRotated: isRotated,
        tabName: maincateg[8],
        icon: CupertinoIcons.bag_fill,
      ),
    ];

    return tabs;
  }
}

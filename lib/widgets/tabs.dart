import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        image: const AssetImage('assets/images/tabImages/men.png'),
      ),
      RepeatedTab(
        isRotated: isRotated,
        tabName: maincateg[1],
        image: const AssetImage('assets/images/tabImages/women.png'),
      ),
      RepeatedTab(
        isRotated: isRotated,
        tabName: maincateg[2],
        image: const AssetImage('assets/images/tabImages/accessories.png'),
      ),
      RepeatedTab(
        isRotated: isRotated,
        tabName: maincateg[3],
        image: const AssetImage('assets/images/tabImages/electronics.png'),
      ),
      RepeatedTab(
        isRotated: isRotated,
        tabName: maincateg[4],
        image: const AssetImage('assets/images/tabImages/shoes.png'),
      ),
      RepeatedTab(
        isRotated: isRotated,
        tabName: maincateg[5],
        image: const AssetImage('assets/images/tabImages/homeandgarden.png'),
      ),
      RepeatedTab(
        isRotated: isRotated,
        tabName: maincateg[6],
        image: const AssetImage('assets/images/tabImages/beauty.png'),
      ),
      RepeatedTab(
        isRotated: isRotated,
        tabName: maincateg[7],
        image: const AssetImage('assets/images/tabImages/kids.png'),
      ),
      RepeatedTab(
        isRotated: isRotated,
        tabName: maincateg[8],
        image: const AssetImage('assets/images/tabImages/bags.png'),
      ),
    ];

    return tabs;
  }
}

import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/tabs.dart';

import '../../utilities/categ_list.dart';
import '../../widgets/category_view_model.dart';
import '../../widgets/search_bottom.dart';

class HomeScrean extends StatefulWidget {
  const HomeScrean({super.key});

  @override
  State<HomeScrean> createState() => _HomeScreanState();
}
// hERE I HAVE CREATED A TABBAR WITH TABBARVIEW.

class _HomeScreanState extends State<HomeScrean> {
  final Tabs _getTabs = Tabs(isRotated: false);

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = _getTabs.getTabs();

    return DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: const SearchBottom(),
          bottom: TabBar(
              padding: EdgeInsets.zero,
              indicatorWeight: 0,
              indicatorPadding: EdgeInsets.zero,
              labelPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              indicatorSize: TabBarIndicatorSize.tab,
              splashBorderRadius: const BorderRadius.all(Radius.circular(8)),
              indicator: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.black12),
              physics: const BouncingScrollPhysics(),
              isScrollable: true,
              tabs: tabs),
        ),
        body:
            // SingleChildScrollView(
            //   child:
            SizedBox(
          height: MediaQuery.of(context).size.height -
              (AppBar().preferredSize.height * 2.5),
          child: Column(
            children: [
              // Expanded(
              //     flex: 2,
              //     child: Image(
              //       image: const AssetImage('assets/images/bags/bags0.jpg'),
              //       width: MediaQuery.of(context).size.width,
              //     )),
              Expanded(
                child: TabBarView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      CategoryViewModel(
                          callPleace: 'home',
                          categoryList: men,
                          headerLabel: maincateg[0],
                          assetImage: 'men/men'),
                      CategoryViewModel(
                          callPleace: 'home',
                          categoryList: women,
                          headerLabel: maincateg[1],
                          assetImage: 'women/women'),
                      CategoryViewModel(
                          callPleace: 'home',
                          categoryList: accessories,
                          headerLabel: maincateg[2],
                          assetImage: 'accessories/accessories'),
                      CategoryViewModel(
                          callPleace: 'home',
                          categoryList: electronics,
                          headerLabel: maincateg[3],
                          assetImage: 'electronics/electronics'),
                      CategoryViewModel(
                          callPleace: 'home',
                          categoryList: shoes,
                          headerLabel: maincateg[4],
                          assetImage: 'shoes/shoes'),
                      CategoryViewModel(
                          callPleace: 'home',
                          categoryList: homeandgarden,
                          headerLabel: maincateg[5],
                          assetImage: 'homegarden/home'),
                      CategoryViewModel(
                          callPleace: 'home',
                          categoryList: beauty,
                          headerLabel: maincateg[6],
                          assetImage: 'beauty/beauty'),
                      CategoryViewModel(
                          callPleace: 'home',
                          categoryList: kids,
                          headerLabel: maincateg[7],
                          assetImage: 'kids/kids'),
                      CategoryViewModel(
                          callPleace: 'home',
                          categoryList: bags,
                          headerLabel: maincateg[8],
                          assetImage: 'bags/bags'),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
    // );
  }
}

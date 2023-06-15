import 'package:flutter/material.dart';

import 'package:multi_store_app/utilities/categ_list.dart';
import 'package:multi_store_app/widgets/category_view_model.dart';
import 'package:multi_store_app/widgets/search_bottom.dart';
import 'package:multi_store_app/widgets/tabs.dart';

double appBarHeight = AppBar().preferredSize.height;

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  late TabController _tabController;
  final Tabs _getTabs = Tabs(isRotated: true);
  bool isAnimating = false;

  @override
  void initState() {
    _tabController = TabController(initialIndex: 0, length: 9, vsync: this);
    tabBarControllerListner();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabController.removeListener(() {});
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const SearchBottom(),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: sideNavigator(size),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: categView(size),
          ),
        ],
      ),
    );
  }

  Widget sideNavigator(Size size) {
    List<Widget> tabs = _getTabs.getTabs();
    return SizedBox(
      width: size.width * 0.25,
      height: size.height - (appBarHeight * 2.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: RotatedBox(
              quarterTurns: 3,
              child: Container(
                color: Colors.amber,
                child: TabBar(
                    padding: EdgeInsets.zero,
                    indicatorPadding: EdgeInsets.zero,
                    labelPadding: EdgeInsets.zero,
                    indicatorSize: TabBarIndicatorSize.label,
                    controller: _tabController,
                    splashBorderRadius:
                        const BorderRadius.all(Radius.circular(8)),
                    indicator: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.black12),
                    physics: const BouncingScrollPhysics(),
                    isScrollable: true,
                    tabs: tabs),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget categView(Size size) {
    return Container(
      width: size.width * 0.75,
      height: size.height - (appBarHeight * 2.5),
      color: Colors.white,
      child: PageView(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (value) {
          _tabController.animateTo(value,
              duration: const Duration(milliseconds: 100),
              curve: Curves.bounceInOut);
        },
        scrollDirection: Axis.vertical,
        children: [
          CategoryViewModel(
              callPleace: 'category',
              categoryList: men,
              headerLabel: maincateg[0],
              assetImage: 'men/men'),
          CategoryViewModel(
              callPleace: 'category',
              categoryList: women,
              headerLabel: maincateg[1],
              assetImage: 'women/women'),
          CategoryViewModel(
              callPleace: 'category',
              categoryList: accessories,
              headerLabel: maincateg[2],
              assetImage: 'accessories/accessories'),
          CategoryViewModel(
              callPleace: 'category',
              categoryList: electronics,
              headerLabel: maincateg[3],
              assetImage: 'electronics/electronics'),
          CategoryViewModel(
              callPleace: 'category',
              categoryList: shoes,
              headerLabel: maincateg[4],
              assetImage: 'shoes/shoes'),
          CategoryViewModel(
              callPleace: 'category',
              categoryList: homeandgarden,
              headerLabel: maincateg[5],
              assetImage: 'homegarden/home'),
          CategoryViewModel(
              callPleace: 'category',
              categoryList: beauty,
              headerLabel: maincateg[6],
              assetImage: 'beauty/beauty'),
          CategoryViewModel(
              callPleace: 'category',
              categoryList: kids,
              headerLabel: maincateg[7],
              assetImage: 'kids/kids'),
          CategoryViewModel(
              callPleace: 'category',
              categoryList: bags,
              headerLabel: maincateg[8],
              assetImage: 'bags/bags'),
        ],
      ),
    );
  }

  void tabBarControllerListner() {
    _tabController.addListener(() {
      if (!isAnimating) {
        isAnimating = true;
        _pageController
            .animateToPage(
          _tabController.index,
          duration: const Duration(milliseconds: 100),
          curve: Curves.bounceInOut,
        )
            .then((_) {
          isAnimating = false;
        });
      }
    });
  }
}

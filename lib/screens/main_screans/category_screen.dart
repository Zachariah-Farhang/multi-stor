import 'package:flutter/material.dart';

import 'package:multi_store_app/utilities/categ_list.dart';
import 'package:multi_store_app/models/category_view_model.dart';
import 'package:multi_store_app/widgets/search_bottom_widget.dart';
import 'package:multi_store_app/widgets/tabs_widget.dart';

double appBarHeight = AppBar().preferredSize.height;

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  bool isAnimating = false;

  final Tabs _getTabs = Tabs(isRotated: true);
  final PageController _pageController = PageController();
  late TabController _tabController;

  @override
  void dispose() {
    _pageController.dispose();
    _tabController.removeListener(() {});
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _tabController = TabController(initialIndex: 0, length: 9, vsync: this);
    tabBarControllerListner();
    super.initState();
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
                color: Colors.white,
                child: TabBar(
                    labelStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                    indicatorWeight: 0,
                    padding: EdgeInsets.zero,
                    indicatorPadding: EdgeInsets.zero,
                    labelPadding: EdgeInsets.zero,
                    indicatorSize: TabBarIndicatorSize.tab,
                    controller: _tabController,
                    indicator: const BoxDecoration(color: Colors.black12),
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
      color: Colors.black12,
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
            categoryList: men,
            headerLabel: maincateg[0],
            assetImage: 'men/men',
          ),
          CategoryViewModel(
            categoryList: women,
            headerLabel: maincateg[1],
            assetImage: 'women/women',
          ),
          CategoryViewModel(
            categoryList: accessories,
            headerLabel: maincateg[2],
            assetImage: 'accessories/accessories',
          ),
          CategoryViewModel(
            categoryList: electronics,
            headerLabel: maincateg[3],
            assetImage: 'electronics/electronics',
          ),
          CategoryViewModel(
            categoryList: shoes,
            headerLabel: maincateg[4],
            assetImage: 'shoes/shoes',
          ),
          CategoryViewModel(
            categoryList: homeandgarden,
            headerLabel: maincateg[5],
            assetImage: 'homegarden/home',
          ),
          CategoryViewModel(
            categoryList: beauty,
            headerLabel: maincateg[6],
            assetImage: 'beauty/beauty',
          ),
          CategoryViewModel(
            categoryList: kids,
            headerLabel: maincateg[7],
            assetImage: 'kids/kids',
          ),
          CategoryViewModel(
            categoryList: bags,
            headerLabel: maincateg[8],
            assetImage: 'bags/bags',
          ),
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
}

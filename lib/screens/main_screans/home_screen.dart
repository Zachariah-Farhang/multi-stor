import 'package:flutter/material.dart';
import 'package:multi_store_app/screens/main_screans/gallery_screen.dart';
import 'package:multi_store_app/widgets/tabs_widget.dart';

import '../../widgets/search_bottom_widget.dart';

class HomeScrean extends StatefulWidget {
  const HomeScrean({
    super.key,
    this.backButtom,
  });

  final Widget? backButtom;

  @override
  State<HomeScrean> createState() => _HomeScreanState();
}
// hERE I HAVE CREATED A TABBAR WITH TABBARVIEW.

class _HomeScreanState extends State<HomeScrean> {
  final Tabs _getTabs = Tabs(isRotated: false);
  final GlobalKey<ScaffoldMessengerState> _scafoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = _getTabs.getTabs();

    return DefaultTabController(
      length: 9,
      child: ScaffoldMessenger(
        key: _scafoldKey,
        child: Scaffold(
          backgroundColor: Colors.black12,
          appBar: AppBar(
            leading: widget.backButtom,
            toolbarHeight: 80,
            elevation: 0.0,
            backgroundColor: Colors.white,
            title: const SearchBottom(),
            bottom: TabBar(
                padding: EdgeInsets.zero,
                indicatorWeight: 0,
                indicatorPadding: EdgeInsets.zero,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                labelPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                indicatorSize: TabBarIndicatorSize.tab,
                splashBorderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                indicator: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
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
                Expanded(
                  child: TabBarView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        GalleryScreen(
                          category: 'مردانه',
                          scafoldKey: _scafoldKey,
                        ),
                        GalleryScreen(
                          category: 'زنانه',
                          scafoldKey: _scafoldKey,
                        ),
                        GalleryScreen(
                          category: 'لوازم جانبی',
                          scafoldKey: _scafoldKey,
                        ),
                        GalleryScreen(
                          category: 'الکترونیک',
                          scafoldKey: _scafoldKey,
                        ),
                        GalleryScreen(
                          category: 'کفش',
                          scafoldKey: _scafoldKey,
                        ),
                        GalleryScreen(
                          category: 'خانه و باغ',
                          scafoldKey: _scafoldKey,
                        ),
                        GalleryScreen(
                          category: 'زیبایی',
                          scafoldKey: _scafoldKey,
                        ),
                        GalleryScreen(
                          category: 'کودکان',
                          scafoldKey: _scafoldKey,
                        ),
                        GalleryScreen(
                          category: 'کیف و کوله',
                          scafoldKey: _scafoldKey,
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // );
  }
}

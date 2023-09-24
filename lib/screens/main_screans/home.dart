import 'package:flutter/material.dart';
import 'package:multi_store_app/galleries/gallery.dart';
import 'package:multi_store_app/widgets/tabs.dart';

import '../../widgets/search_bottom.dart';

class HomeScrean extends StatefulWidget {
  final Widget? backButtom;
  const HomeScrean({
    super.key,
    this.backButtom,
  });

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
          child: const Column(
            children: [
              Expanded(
                child: TabBarView(physics: BouncingScrollPhysics(), children: [
                  GalleryScreen(
                    category: 'مردانه',
                  ),
                  GalleryScreen(
                    category: 'زنانه',
                  ),
                  GalleryScreen(
                    category: 'لوازم جانبی',
                  ),
                  GalleryScreen(
                    category: 'الکترونیک',
                  ),
                  GalleryScreen(
                    category: 'کفش',
                  ),
                  GalleryScreen(
                    category: 'خانه و باغ',
                  ),
                  GalleryScreen(
                    category: 'زیبایی',
                  ),
                  GalleryScreen(
                    category: 'کودکان',
                  ),
                  GalleryScreen(
                    category: 'کیف و کوله',
                  ),
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

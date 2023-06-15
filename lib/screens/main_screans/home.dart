import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/tabs.dart';

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
          toolbarHeight: 60,
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: const SearchBottom(),
          bottom: TabBar(
              splashBorderRadius: const BorderRadius.all(Radius.circular(8)),
              indicator: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.black12),
              physics: const BouncingScrollPhysics(),
              isScrollable: true,
              tabs: tabs),
        ),
        body: const TabBarView(physics: BouncingScrollPhysics(), children: [
          Center(child: Text('Men Screan')),
          Center(child: Text('Women Screan')),
          Center(child: Text('electronics Screan')),
          Center(child: Text('accessories Screan')),
          Center(child: Text('shoes Screan')),
          Center(child: Text('home & garden Screan')),
          Center(child: Text('beauty Screan')),
          Center(child: Text('kids Screan')),
          Center(child: Text('bags Screan')),
        ]),
      ),
    );
  }
}

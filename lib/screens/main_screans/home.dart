import 'package:flutter/material.dart';

import '../../widgets/search_bottom.dart';

class HomeScrean extends StatefulWidget {
  const HomeScrean({super.key});

  @override
  State<HomeScrean> createState() => _HomeScreanState();
}
// hERE I HAVE CREATED A TABBAR WITH TABBARVIEW.

class _HomeScreanState extends State<HomeScrean> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: const SearchBottom(),
          bottom: const TabBar(
            physics: BouncingScrollPhysics(),
            isScrollable: true,
            indicatorColor: Colors.yellow,
            indicatorWeight: 8.0,
            tabs: [
              RepeatedTab(tabName: 'Men'),
              RepeatedTab(tabName: 'Women'),
              RepeatedTab(tabName: 'electronics'),
              RepeatedTab(tabName: 'accessories'),
              RepeatedTab(tabName: 'shoes'),
              RepeatedTab(tabName: 'home & garden'),
              RepeatedTab(tabName: 'beauty'),
              RepeatedTab(tabName: 'kids'),
              RepeatedTab(tabName: 'bags'),
            ],
          ),
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

// HERE I HAVE CREATED A CLASS FOR REPEATED TAB.
class RepeatedTab extends StatelessWidget {
  final String tabName;
  const RepeatedTab({
    super.key,
    required this.tabName,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        tabName,
        style: TextStyle(color: Colors.grey.shade600),
      ),
    );
  }
}

import 'package:flutter/material.dart';

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
          title: Container(
              height: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(color: Colors.yellow, width: 1.4)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Icon(Icons.search, color: Colors.grey),
                      ),
                      Text(
                        'What are you looking for?',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 32,
                    width: 75,
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(25)),
                    child: const Center(
                      child: Text(
                        'Search',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  )
                ],
              )),
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

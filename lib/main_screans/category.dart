import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/search_bottom.dart';

List<ItemData> items = [
  ItemData(label: 'men', isSelected: false),
  ItemData(label: 'women', isSelected: false),
  ItemData(label: 'electronics', isSelected: false),
  ItemData(label: 'accessories', isSelected: false),
  ItemData(label: 'shoes', isSelected: false),
  ItemData(label: 'home & garden', isSelected: false),
  ItemData(label: 'beauty', isSelected: false),
  ItemData(label: 'kids', isSelected: false),
  ItemData(label: 'bags', isSelected: false),
];

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    for (var element in items) {
      element.isSelected = false;
      setState(() {
        items[0].isSelected = true;
      });
    }
    super.initState();
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
      body: Stack(children: [
        Positioned(bottom: 0, left: 0, child: sideNavigator(size)),
        Positioned(bottom: 0, right: 0, child: categView(size))
      ]),
    );
  }

  Widget sideNavigator(Size size) {
    return SizedBox(
      width: size.width * 0.25,
      height: size.height * 0.8,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn);
            },
            child: Container(
                color: items[index].isSelected
                    ? Colors.white
                    : Colors.grey.shade300,
                height: 100,
                child: Center(child: Text(items[index].label))),
          );
        },
      ),
    );
  }

  Widget categView(Size size) {
    return Container(
      width: size.width * 0.75,
      height: size.height * 0.8,
      color: Colors.white,
      child: PageView(
          controller: _pageController,
          physics: const BouncingScrollPhysics(),
          onPageChanged: (value) {
            for (var element in items) {
              element.isSelected = false;
              setState(() {
                items[value].isSelected = true;
              });
            }
          },
          scrollDirection: Axis.vertical,
          children: const [
            Center(child: Text("men")),
            Center(child: Text("women")),
            Center(child: Text("accessories")),
            Center(child: Text("electronics")),
            Center(child: Text("shoes")),
            Center(child: Text("home & garden")),
            Center(child: Text("beauty")),
            Center(child: Text("kids")),
            Center(child: Text("bogs")),
          ]),
    );
  }
}

class ItemData {
  String label;
  bool isSelected;
  ItemData({required this.label, this.isSelected = false});
}

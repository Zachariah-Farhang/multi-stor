import 'package:flutter/material.dart';
import 'package:multi_store_app/categoreis/men_category.dart';
import 'package:multi_store_app/categoreis/women_category.dart';
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

double appBarHeight = AppBar().preferredSize.height;
double bottomBarHeight = appBarHeight;

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();
  bool _portrait = true;
  int _selectedIndex = 0;
  @override
  void initState() {
    items[0].isSelected = true;
    _selectedIndex = 0;
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: const SearchBottom(),
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              _portrait = true;
            } else {
              _portrait = false;
            }

            return Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: sideNavigator(size),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: categView(size),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget sideNavigator(Size size) {
    return SizedBox(
      width: size.width * 0.25,
      height: size.height - bottomBarHeight - appBarHeight,
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 24),
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Ink(
            color: items[index].isSelected && index == _selectedIndex
                ? Colors.white
                : Colors.grey.shade300,
            child: InkWell(
              onTap: () {
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeIn,
                );
              },
              splashColor: Colors.yellow.shade500,
              // highlightColor: Colors.yellow.shade500,
              child: SizedBox(
                height: 100,
                child: Center(child: Text(items[index].label)),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget categView(Size size) {
    return Container(
      width: size.width * 0.75,
      height: size.height - bottomBarHeight - appBarHeight,
      color: Colors.white,
      child: PageView(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (value) {
          _selectItem(value, size);
        },
        scrollDirection: Axis.vertical,
        children: const [
          MenCategory(),
          WomenCategory(),
          Center(child: Text("women")),
          Center(child: Text("accessories")),
          Center(child: Text("electronics")),
          Center(child: Text("shoes")),
          Center(child: Text("home & garden")),
          Center(child: Text("beauty")),
          Center(child: Text("kids")),
          Center(child: Text("bags")),
        ],
      ),
    );
  }

  void _selectItem(int index, Size size) {
    setState(() {
      items[_selectedIndex].isSelected = false;
      items[index].isSelected = true;
      _selectedIndex = index;
      _scrollToIndex(
          index, _portrait ? size.height * 0.075 : size.height * 0.20);
    });
  }

  void _scrollToIndex(int index, double itemExtent) {
    double offset = index * itemExtent;

    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}

class ItemData {
  String label;
  bool isSelected;
  ItemData({required this.label, this.isSelected = false});
}

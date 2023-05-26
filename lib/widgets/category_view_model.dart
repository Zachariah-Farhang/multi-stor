import 'package:flutter/material.dart';

import 'categ_widget.dart';

class CategoryViewModel extends StatelessWidget {
  final List<String> categoryList;
  final String headerLabel;
  final String assetImage;
  const CategoryViewModel({
    super.key,
    required this.screanWidth,
    required this.mainHeight,
    required this.categoryList,
    required this.headerLabel,
    required this.assetImage,
  });

  final double screanWidth;
  final double mainHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: mainHeight,
              child: Stack(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CategHeaderLebel(
                      headerLebel: headerLabel,
                    ),
                    Expanded(
                      child: GridView.count(
                        physics: const BouncingScrollPhysics(),
                        mainAxisSpacing: 50,
                        crossAxisCount: 3,
                        children: List.generate(categoryList.length, (index) {
                          return SubCategModel(
                            maincategName: headerLabel,
                            subcategName: categoryList[index],
                            assteImage: 'assets/images/$assetImage$index.jpg',
                            subcategLebel: categoryList[index],
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ),
          SliderBar(
              maincategName: headerLabel.toUpperCase(),
              mainHeight: mainHeight,
              screanWidth: screanWidth)
        ],
      ),
    );
  }
}

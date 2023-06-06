import 'package:flutter/material.dart';

import 'categ_widget.dart';

class CategoryViewModel extends StatelessWidget {
  final List<String> categoryList;
  final String headerLabel;
  final String assetImage;
  const CategoryViewModel({
    super.key,
    required this.categoryList,
    required this.headerLabel,
    required this.assetImage,
  });
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
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
                          mainAxisSpacing: 30,
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
            )
          ],
        ),
      ),
    );
  }
}

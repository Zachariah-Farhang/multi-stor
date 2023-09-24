import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Row(
          children: [
            Expanded(
              child: Stack(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CategHeaderLebel(
                      headerLebel: headerLabel,
                    ),
                    Expanded(
                      child: MasonryGridView.count(
                        physics: const BouncingScrollPhysics(),
                        itemCount: categoryList.length,
                        crossAxisCount: 2,
                        itemBuilder: (context, index) {
                          return SubCategModel(
                            maincategName: headerLabel,
                            subcategName: categoryList[index],
                            assteImage: 'assets/images/$assetImage$index.jpg',
                            subcategLebel: categoryList[index],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ]),
            ),
            SliderBar(
              maincategName: headerLabel,
            )
          ],
        ),
      ),
    );
  }
}

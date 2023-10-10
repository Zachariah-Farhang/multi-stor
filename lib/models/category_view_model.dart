import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../widgets/categ_widget.dart';

class CategoryViewModel extends StatelessWidget {
  const CategoryViewModel({
    super.key,
    required this.categoryList,
    required this.headerLabel,
    required this.assetImage,
  });

  final String assetImage;
  final List<String> categoryList;
  final String headerLabel;

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
                        padding: const EdgeInsets.all(8),
                        physics: const BouncingScrollPhysics(),
                        itemCount: categoryList.length,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
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

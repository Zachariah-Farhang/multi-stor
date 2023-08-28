import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

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
                      child: StaggeredGridView.countBuilder(
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
                          staggeredTileBuilder: (context) =>
                              const StaggeredTile.fit(1)),
                      // child: GridView.count(
                      //   physics: const BouncingScrollPhysics(),
                      //   mainAxisSpacing: 20,
                      //   crossAxisCount: 2,
                      //   children: List.generate(categoryList.length, (index) {
                      //     return SubCategModel(
                      //       maincategName: headerLabel,
                      //       subcategName: categoryList[index],
                      //       assteImage: 'assets/images/$assetImage$index.jpg',
                      //       subcategLebel: categoryList[index],
                      //     );
                      //   }),
                      // ),
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

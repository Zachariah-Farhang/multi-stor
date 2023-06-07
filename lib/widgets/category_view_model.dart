import 'package:flutter/material.dart';

import 'categ_widget.dart';

class CategoryViewModel extends StatelessWidget {
  final List<String> categoryList;
  final String headerLabel;
  final String assetImage;
  final String callPleace;
  const CategoryViewModel({
    super.key,
    required this.categoryList,
    required this.headerLabel,
    required this.assetImage,
    required this.callPleace,
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
                    callPleace == 'category'
                        ? CategHeaderLebel(
                            headerLebel: headerLabel,
                          )
                        : const SizedBox(
                            height: 4,
                          ),
                    Expanded(
                      child: GridView.count(
                        physics: const BouncingScrollPhysics(),
                        mainAxisSpacing: 30,
                        crossAxisCount: 3,
                        children: List.generate(categoryList.length, (index) {
                          return SubCategModel(
                            callPleace: callPleace,
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
            callPleace == 'category'
                ? SliderBar(
                    maincategName: headerLabel,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

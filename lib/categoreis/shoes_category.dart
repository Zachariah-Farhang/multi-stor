import 'package:flutter/material.dart';
import 'package:multi_store_app/utilities/categ_list.dart';

import '../widgets/categ_widget.dart';

double appBarHeight = AppBar().preferredSize.height;

class ShoesCategory extends StatelessWidget {
  const ShoesCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final screanWidth = MediaQuery.of(context).size.width;
    final screanHeight = MediaQuery.of(context).size.height;
    final mainHeight = screanHeight - (appBarHeight * 2.5);
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          child: SizedBox(
            width: screanWidth * 0.70,
            height: mainHeight,
            child: Stack(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CategHeaderLebel(
                    headerLebel: 'Shoes',
                  ),
                  Expanded(
                    child: GridView.count(
                      physics: const BouncingScrollPhysics(),
                      mainAxisSpacing: 50,
                      crossAxisSpacing: 15,
                      crossAxisCount: 3,
                      children: List.generate(shoes.length, (index) {
                        return SubCategModel(
                          maincategName: 'Shoes',
                          subcategName: shoes[index],
                          assteImage: 'assets/images/shoes/shoes$index.jpg',
                          subcategLebel: shoes[index],
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: SliderBar(
              maincategName: 'shoes',
              mainHeight: mainHeight,
              screanWidth: screanWidth),
        )
      ],
    );
  }
}

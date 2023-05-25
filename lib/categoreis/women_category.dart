import 'package:flutter/material.dart';
import 'package:multi_store_app/utilities/categ_list.dart';

import '../widgets/categ_widget.dart';

double appBarHeight = AppBar().preferredSize.height;

class WomenCategory extends StatelessWidget {
  const WomenCategory({super.key});

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
                    headerLebel: 'Women',
                  ),
                  Expanded(
                    child: GridView.count(
                      physics: const BouncingScrollPhysics(),
                      mainAxisSpacing: 50,
                      crossAxisSpacing: 15,
                      crossAxisCount: 3,
                      children: List.generate(men.length, (index) {
                        return SubCategModel(
                          maincategName: 'Women',
                          subcategName: women[index],
                          assteImage: 'assets/images/women/women$index.jpg',
                          subcategLebel: women[index],
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
              maincategName: 'women',
              mainHeight: mainHeight,
              screanWidth: screanWidth),
        )
      ],
    );
  }
}

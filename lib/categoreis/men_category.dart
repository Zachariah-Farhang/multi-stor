import 'package:flutter/material.dart';
import 'package:multi_store_app/utilities/categ_list.dart';

import '../minor_screens/sub_gategories.dart';

double appBarHeight = AppBar().preferredSize.height;
double bottomBarHeight = appBarHeight;

class MenCategory extends StatelessWidget {
  const MenCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(30.0),
          child: Text(
            'Men',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height -
              appBarHeight -
              bottomBarHeight -
              100,
          child: GridView.count(
            physics: const BouncingScrollPhysics(),
            mainAxisSpacing: 50,
            crossAxisSpacing: 15,
            crossAxisCount: 3,
            children: List.generate(men.length, (index) {
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: Image(
                          image: AssetImage('assets/images/men/men$index.jpg'),
                        ),
                      ),
                      Text(
                        men[index],
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubGategories(
                          subcategName: men[index],
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

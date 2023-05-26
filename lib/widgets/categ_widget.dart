import 'package:flutter/material.dart';

import '../screens/minor_screens/sub_gategories.dart';

class SliderBar extends StatelessWidget {
  final String maincategName;
  const SliderBar({
    super.key,
    required this.mainHeight,
    required this.screanWidth,
    required this.maincategName,
  });

  final double mainHeight;
  final double screanWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: mainHeight,
      width: screanWidth * 0.05,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.brown.withOpacity(0.2),
            borderRadius: BorderRadius.circular(50),
          ),
          child: RotatedBox(
            quarterTurns: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  '<<',
                  style: TextStyle(
                      color: Colors.brown,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 10),
                ),
                Text(
                  maincategName.toUpperCase(),
                  style: const TextStyle(
                      color: Colors.brown,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 10),
                ),
                const Text(
                  '>>',
                  style: TextStyle(
                      color: Colors.brown,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 10),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SubCategModel extends StatelessWidget {
  final String maincategName;
  final String subcategName;
  final String assteImage;
  final String subcategLebel;
  const SubCategModel({
    super.key,
    required this.maincategName,
    required this.subcategName,
    required this.assteImage,
    required this.subcategLebel,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: Column(
          children: [
            SizedBox(
              height: 70,
              width: 70,
              child: Image(
                image: AssetImage(assteImage),
              ),
            ),
            Text(
              subcategLebel,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
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
                subcategName: subcategName,
                maincategName: maincategName,
              ),
            ),
          );
        },
      ),
    );
  }
}

class CategHeaderLebel extends StatelessWidget {
  final String headerLebel;
  const CategHeaderLebel({
    super.key,
    required this.headerLebel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 5.0, 0.0, 10.0),
      child: Text(
        headerLebel,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}

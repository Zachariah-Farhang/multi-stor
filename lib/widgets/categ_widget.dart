import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/reuseable_matrial_continer.dart';

import '../screens/minor_screens/sub_gategories.dart';

class SliderBar extends StatelessWidget {
  final String maincategName;
  const SliderBar({
    super.key,
    required this.maincategName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.brown.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: RotatedBox(
          quarterTurns: 3,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const AutoSizeText(
                '<<',
                minFontSize: 16,
                style: TextStyle(
                    color: Colors.brown,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 10),
              ),
              AutoSizeText(
                maincategName,
                minFontSize: 10,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.brown,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const AutoSizeText(
                '>>',
                minFontSize: 16,
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
    return MaterialReuseableCotiner(
      text: subcategLebel,
      imagePath: assteImage,
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
    return FittedBox(
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: AutoSizeText(
          headerLebel,
          maxLines: 2,
          minFontSize: 22,
          style: const TextStyle(
            fontSize: 24,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}

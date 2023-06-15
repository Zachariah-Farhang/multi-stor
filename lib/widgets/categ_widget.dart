import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

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
  final String callPleace;

  const SubCategModel({
    super.key,
    required this.maincategName,
    required this.subcategName,
    required this.assteImage,
    required this.subcategLebel,
    required this.callPleace,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      splashColor: Colors.black54,
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.only(bottom: 4),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                  ),
                  color: Colors.white,
                ),
                child: Image(
                  image: AssetImage(assteImage),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: AutoSizeText(
                  subcategLebel,
                  minFontSize: 16,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    overflow: TextOverflow.visible,
                  ),
                ),
              ),
            ),
          ],
        ),
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

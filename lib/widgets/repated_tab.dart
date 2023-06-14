import 'package:flutter/material.dart';

class RepeatedTab extends StatelessWidget {
  final String tabName;
  final AssetImage image;
  final bool isRotated;
  const RepeatedTab({
    super.key,
    required this.tabName,
    required this.image,
    required this.isRotated,
  });

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: isRotated ? 1 : 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: Image(image: image),
                ),
              ),
              Text(
                tabName,
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

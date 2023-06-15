import 'package:flutter/material.dart';

class RepeatedTab extends StatelessWidget {
  final String tabName;
  final IconData icon;
  final bool isRotated;
  const RepeatedTab({
    super.key,
    required this.tabName,
    required this.icon,
    required this.isRotated,
  });

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
        quarterTurns: isRotated ? 1 : 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.grey.shade600,
                ),
              ],
            ),
            const SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  tabName,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ],
        ));
  }
}

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
        child: Container(
          padding: const EdgeInsets.all(8),
          height: AppBar().preferredSize.height + 20,
          child: Tab(
            icon: Icon(
              icon,
              color: Colors.grey.shade600,
            ),
            child: Text(
              tabName,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
        )

        //  Container(
        //   height: AppBar().preferredSize.height + 10,
        //   width: 70,
        //   color: Colors.amber,
        //   child: Column(
        //     children: [
        //       const SizedBox(
        //         height: 8,
        //       ),
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Icon(
        //             icon,
        //             color: Colors.grey.shade600,
        //           ),
        //         ],
        //       ),
        //       const SizedBox(
        //         height: 2,
        //       ),
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Text(
        //             tabName,
        //             style: TextStyle(color: Colors.grey.shade600),
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        // )

        );
  }
}

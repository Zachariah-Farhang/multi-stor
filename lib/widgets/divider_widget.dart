import 'package:flutter/material.dart';

class ReuseableDivider extends StatelessWidget {
  const ReuseableDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Divider(
        color: Colors.amber,
        thickness: 1,
      ),
    );
  }
}

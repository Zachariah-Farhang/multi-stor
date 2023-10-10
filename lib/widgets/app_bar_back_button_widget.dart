import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          CupertinoIcons.back,
          color: color,
        ),
        onPressed: () => Navigator.of(context).pop());
  }
}

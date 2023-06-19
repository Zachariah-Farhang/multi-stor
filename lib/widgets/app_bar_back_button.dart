import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(
          CupertinoIcons.back,
          color: Colors.black,
        ),
        onPressed: () => Navigator.of(context).pop());
  }
}

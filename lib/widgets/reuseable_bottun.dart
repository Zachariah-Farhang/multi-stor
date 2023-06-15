import 'package:flutter/material.dart';

class ReuseableButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;
  final Color? color;
  const ReuseableButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 0,
      fillColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0), // Adjust the value as needed
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}

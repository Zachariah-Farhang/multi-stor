import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/reuseable_bottun.dart';

class ReusableCotiner extends StatelessWidget {
  final Widget child;
  final void Function() onPressed;
  final BoxDecoration decoration;
  const ReusableCotiner({
    super.key,
    required this.child,
    required this.onPressed,
    required this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: decoration,
      child: ReuseableButton(
        onPressed: onPressed,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: child,
          ),
        ),
      ),
    );
  }
}

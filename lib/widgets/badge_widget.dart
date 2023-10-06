import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class BadgeWidget extends StatelessWidget {
  const BadgeWidget({
    super.key,
    required this.content,
    required this.child,
  });

  final Widget child;
  final String content;

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: -10, end: -12),
      showBadge: true,
      ignorePointer: false,
      onTap: () {},
      badgeContent: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(content,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
      badgeAnimation: const badges.BadgeAnimation.rotation(
        animationDuration: Duration(seconds: 5),
        colorChangeAnimationDuration: Duration(seconds: 1),
        loopAnimation: true,
        curve: Curves.fastOutSlowIn,
        colorChangeAnimationCurve: Curves.easeInCubic,
      ),
      badgeStyle: badges.BadgeStyle(
        shape: badges.BadgeShape.circle,
        badgeColor: Colors.blue,
        padding: const EdgeInsets.all(6),
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: Colors.white, width: 0),
        badgeGradient: const badges.BadgeGradient.linear(
          colors: [Colors.blue, Colors.yellow],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        elevation: 0,
      ),
      child: child,
    );
  }
}

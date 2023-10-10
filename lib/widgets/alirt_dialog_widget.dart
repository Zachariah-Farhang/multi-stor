import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CuperAlertDialog {
  final BuildContext context;
  final String agree;
  final String title;
  final String descreption;
  final String desAgree;
  final void Function() agreeFun;
  final void Function() desAgreeFun;
  const CuperAlertDialog(
      {required this.context,
      required this.agree,
      required this.desAgree,
      required this.agreeFun,
      required this.desAgreeFun,
      required this.title,
      required this.descreption});

  void showAlertDialog() {
    showCupertinoModalPopup<void>(
      barrierDismissible: false,
      barrierColor: Colors.black54,
      context: context,
      builder: (BuildContext context) => Directionality(
        textDirection: TextDirection.rtl,
        child: CupertinoAlertDialog(
          insetAnimationCurve: Curves.easeInToLinear,
          title: Text(
            title,
            style: TextStyle(
                fontSize: 22, fontFamily: 'Kanun', color: Colors.red.shade900),
          ),
          content: Text(
            descreption,
            style: const TextStyle(fontSize: 16, fontFamily: 'Kanun'),
          ),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: agreeFun,
              child: Text(agree),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: desAgreeFun,
              child: Text(desAgree),
            ),
          ],
        ),
      ),
    );
  }
}

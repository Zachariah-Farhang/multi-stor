import 'package:flutter/cupertino.dart';

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
      context: context,
      builder: (BuildContext context) => Directionality(
        textDirection: TextDirection.rtl,
        child: CupertinoAlertDialog(
          title: Text(title),
          content: Text(descreption),
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

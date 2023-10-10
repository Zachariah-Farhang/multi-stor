import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoInternetScreen {
  final BuildContext context;

  const NoInternetScreen({required this.context});

  Widget showModel() {
    return Stack(
      children: [
        CupertinoAlertDialog(
          content: Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: Container(
                color: Colors.transparent,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "به انترنت متصل نیستید \n در حال بررسی",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontFamily: 'Kanun', fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CupertinoActivityIndicator(
                      radius: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // ModalBarrier to block interactions
        const ModalBarrier(
          dismissible: false,
        ),
      ],
    );
  }
}

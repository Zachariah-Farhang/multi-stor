import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoInternetScreen {
  final BuildContext context;

  const NoInternetScreen({required this.context});

  Widget showModel() {
    return const Stack(
      children: [
        ModalBarrier(
          dismissible: false,
        ),
        CupertinoAlertDialog(
          content: Column(
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
                color: Colors.deepPurple,
              ),
            ],
          ),
        ),

        // ModalBarrier to block interactions
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';

class InternetAlertDialog extends StatelessWidget {
  const InternetAlertDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoAlertDialog(
      content: Column(
        children: [
          CupertinoActivityIndicator(
            radius: 30,
          ),
          Text(
            'در حال بررسی اتصال به اینترنت...',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class LoginBottom extends StatelessWidget {
  final void Function() onTop;
  final String text;
  final String imagePath;
  const LoginBottom({
    super.key,
    required this.onTop,
    required this.text,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTop,
          splashColor: Colors.black38,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
                width: 40,
                child: Image(
                  image: AssetImage(imagePath),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                text,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MaterialReuseableCotiner extends StatelessWidget {
  const MaterialReuseableCotiner({
    super.key,
    required this.text,
    required this.imagePath,
    required this.onTap,
  });
  final String text;
  final String imagePath;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      splashColor: Colors.black54,
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height / 5,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.only(bottom: 4),
                constraints: const BoxConstraints.expand(),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: imagePath.contains('assets')
                        ? AssetImage(
                            imagePath,
                          )
                        : CachedNetworkImageProvider(imagePath)
                            as ImageProvider<Object>,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: AutoSizeText(
                  text,
                  minFontSize: 14,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

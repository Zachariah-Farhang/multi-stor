import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:multi_store_app/widgets/app_bar_back_button.dart';

class ImageViewScreen extends StatefulWidget {
  final List<dynamic> imageList;

  const ImageViewScreen({super.key, required this.imageList});

  @override
  State<ImageViewScreen> createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen> {
  final SwiperController _swiperController = SwiperController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.70,
                      child: Swiper(
                          controller: _swiperController,
                          pagination: SwiperPagination(
                              margin: EdgeInsets.zero,
                              builder: SwiperCustomPagination(
                                  builder: (context, config) {
                                return ConstrainedBox(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: const DotSwiperPaginationBuilder(
                                            color: Colors.amber,
                                            activeColor: Colors.blueAccent,
                                            size: 10.0,
                                            activeSize: 20.0)
                                        .build(context, config),
                                  ),
                                  constraints:
                                      const BoxConstraints.expand(height: 50.0),
                                );
                              })),
                          itemBuilder: (context, index) {
                            return InteractiveViewer(
                              transformationController:
                                  TransformationController(),
                              minScale: 0.5,
                              maxScale: 3,
                              child: Image.network(
                                widget.imageList[index],
                                fit: BoxFit.fill,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child; // Return the child (the image) when loading is complete.
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  }
                                },
                                errorBuilder: (context, exception, stackTrace) {
                                  return Text(
                                      'Image not available'); // Optional: Handle image load errors.
                                },
                              ),
                            );
                          },
                          itemCount: widget.imageList.length),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Material(
                        color: Colors
                            .transparent, // Make the Material widget transparent
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              CupertinoIcons.back,
                              size: 34,
                              color: Color.fromARGB(255, 238, 255, 2),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    color: Colors.black26,
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.imageList.length,
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                            onTap: () {
                              _swiperController.move(index);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              margin: EdgeInsets.all(4),
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(8)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  widget.imageList[index],
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          );
                        })),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}

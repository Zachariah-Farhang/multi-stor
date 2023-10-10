import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/internet_provider.dart';
import '../../widgets/no_internet_widget.dart';

class ImageViewScreen extends StatefulWidget {
  const ImageViewScreen({super.key, required this.imageList});

  final List<dynamic> imageList;

  @override
  State<ImageViewScreen> createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen> {
  final SwiperController _swiperController = SwiperController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child:
          Consumer<ConnectivityProvider>(builder: (context, connection, child) {
        return Stack(
          children: [
            Scaffold(
              body: SafeArea(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.70,
                            color: Colors.black26,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                              child: Swiper(
                                  controller: _swiperController,
                                  pagination: SwiperPagination(
                                      margin: EdgeInsets.zero,
                                      builder: SwiperCustomPagination(
                                          builder: (context, config) {
                                        return ConstrainedBox(
                                          constraints:
                                              const BoxConstraints.expand(
                                                  height: 50.0),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child:
                                                const DotSwiperPaginationBuilder(
                                                        color: Colors.amber,
                                                        activeColor:
                                                            Colors.blueAccent,
                                                        size: 10.0,
                                                        activeSize: 20.0)
                                                    .build(context, config),
                                          ),
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
                                        errorBuilder:
                                            (context, exception, stackTrace) {
                                          return const Text(
                                              'Image not available'); // Optional: Handle image load errors.
                                        },
                                      ),
                                    );
                                  },
                                  itemCount: widget.imageList.length),
                            ),
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
                                  padding: const EdgeInsets.all(10),
                                  child: const Icon(
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
                          padding: const EdgeInsets.only(bottom: 4, top: 4),
                          color: Colors.black26,
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.imageList.length,
                              itemBuilder: ((context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    _swiperController.move(index);
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    margin: const EdgeInsets.all(4),
                                    padding: const EdgeInsets.all(2),
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
            if (!connection.isInternetStable)
              NoInternetScreen(context: context).showModel()
          ],
        );
      }),
    );
  }
}

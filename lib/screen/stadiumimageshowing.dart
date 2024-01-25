import 'package:fansseathub/helper/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class StadiumImage extends StatefulWidget {
  final String image;
  const StadiumImage({super.key, required this.image});

  @override
  State<StadiumImage> createState() => _StadiumImageState();
}

class _StadiumImageState extends State<StadiumImage> {
  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    final mediaheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Heading(),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          width: mediaWidth,
          height: mediaheight,
          decoration: BoxDecoration(color: Colors.white),
          child: PhotoView(
            imageProvider: NetworkImage(widget.image),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
            enableRotation: true,
            heroAttributes: const PhotoViewHeroAttributes(tag: 'stadiumImage'),
          ),
        ),
      ),
    );
  }
}

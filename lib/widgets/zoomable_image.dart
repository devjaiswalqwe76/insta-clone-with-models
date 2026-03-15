import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ZoomableImage extends StatelessWidget {

  final String image;

  const ZoomableImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {

        showDialog(
          context: context,
          builder: (_) {

            return Dialog(
              backgroundColor: Colors.black,
              insetPadding: EdgeInsets.zero,
              child: PhotoView(
                imageProvider: AssetImage(image),
                backgroundDecoration:
                const BoxDecoration(color: Colors.black),
              ),
            );
          },
        );

      },

      child: Image.asset(
        image,
        fit: BoxFit.cover,
        width: double.infinity,
      ),
    );
  }
}
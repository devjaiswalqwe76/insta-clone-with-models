import 'package:flutter/material.dart' hide CarouselController;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageCarousel extends StatefulWidget {
  final List<String> images;

  const ImageCarousel({super.key, required this.images});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider.builder(
          itemCount: widget.images.length,
          itemBuilder: (context, index, realIndex) {
            final image = widget.images[index];
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: image.startsWith('http')
                  ? CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(color: Colors.grey[200]),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    )
                  : Image.asset(image, fit: BoxFit.cover),
            );
          },
          options: CarouselOptions(
            aspectRatio: 1,
            viewportFraction: 1,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              setState(() {
                activeIndex = index;
              });
            },
          ),
        ),
        if (widget.images.length > 1)
          Positioned(
            bottom: 10,
            child: AnimatedSmoothIndicator(
              activeIndex: activeIndex,
              count: widget.images.length,
              effect: const ScrollingDotsEffect(
                dotHeight: 6,
                dotWidth: 6,
                activeDotColor: Colors.blue,
                dotColor: Colors.white54,
              ),
            ),
          ),
      ],
    );
  }
}

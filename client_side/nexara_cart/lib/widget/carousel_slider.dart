import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../utility/app_color.dart';
import '../models/product.dart';
import '../utility/constants.dart';
import '../utility/utility_extention.dart';
import 'custom_network_image.dart';

class CarouselSlider extends StatefulWidget {
  const CarouselSlider({
    super.key,
    required this.items,
  });

  final List<Images> items;

  @override
  State<CarouselSlider> createState() => _CarouselSliderState();
}

class _CarouselSliderState extends State<CarouselSlider> {
  int newIndex = 0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: height * 0.32,
          child: PageView.builder(
            itemCount: widget.items.length,
            onPageChanged: (int currentIndex) {
              newIndex = currentIndex;
              setState(() {});
            },
            itemBuilder: (_, index) {
              return FittedBox(
                fit: BoxFit.none,
                child: CustomNetworkImage(
                  imageUrl: widget.items.safeElementAt(index)?.url == null
                      ? ''
                      : '$SERVER_URL${widget.items.safeElementAt(index)?.url}',
                  fit: BoxFit.contain,
                  scale: 3.0,
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        AnimatedSmoothIndicator(
          effect: const WormEffect(
            dotColor: Colors.grey,
            activeDotColor: AppColor.darkAccent,
            dotWidth: 8,
            dotHeight: 8,
          ),
          count: widget.items.length,
          activeIndex: newIndex,
        )
      ],
    );
  }
}

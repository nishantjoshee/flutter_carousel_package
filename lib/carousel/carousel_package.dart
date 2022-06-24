import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Carousel extends StatefulWidget {
  Carousel({
    Key? key,
    required this.items,
    this.outerContainerColor = Colors.green,
    this.outerContainerHeight = 320,
    this.carouselHeight = 320,
    this.infinityScroll = false,
    this.dotColor = Colors.grey,
    this.activeDotColor = Colors.blueAccent,
    this.dotHeight = 8,
    this.dotWidth = 8,
    this.viewPortFraction = 1,
    this.navWidgetLeft = const CircleAvatar(
      radius: 15,
      child: Icon(
        Icons.arrow_back_ios,
        size: 18,
      ),
    ),
    this.navWidgetRight = const CircleAvatar(
      radius: 15,
      child: Icon(
        Icons.arrow_forward_ios,
        size: 18,
      ),
    ),
  }) : super(key: key);
  final List<Widget> items;
  Color outerContainerColor;
  double outerContainerHeight;
  double carouselHeight;
  bool infinityScroll;
  Color dotColor;
  Color activeDotColor;
  double dotHeight;
  double dotWidth;
  Widget navWidgetLeft;
  Widget navWidgetRight;
  double viewPortFraction;
  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int activeIndex = 0;
  final controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: widget.outerContainerHeight,
          color: widget.outerContainerColor,
        ),
        CarouselSlider(
          carouselController: controller,
          items: widget.items,
          options: CarouselOptions(
            enableInfiniteScroll: widget.infinityScroll,
            viewportFraction: widget.viewPortFraction,
            height: widget.carouselHeight,
            autoPlay: false,
            onPageChanged: (index, reason) {
              setState(() {
                activeIndex = index;
              });
            },
          ),
        ),
        Positioned(
          bottom: 0,
          left: 140,
          right: 0,
          top: 275,
          child: AnimatedSmoothIndicator(
            onDotClicked: (index) {
              controller.animateToPage(index);
            },
            effect: SlideEffect(
              dotWidth: widget.dotHeight,
              dotHeight: widget.dotWidth,
              dotColor: widget.dotColor,
              activeDotColor: widget.activeDotColor,
            ),
            activeIndex: activeIndex,
            count: widget.items.length,
          ),
        ),
        Positioned(
          top: 140,
          left: 5,
          child: InkWell(
            onTap: () {
              controller.previousPage();
            },
            child: widget.navWidgetLeft,
          ),
        ),
        Positioned(
          top: 140,
          right: 5,
          child: InkWell(
            onTap: () {
              controller.nextPage();
            },
            child: widget.navWidgetRight,
          ),
        )
      ],
    );
  }
}

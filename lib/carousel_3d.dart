library carousel_3d;

import 'package:flutter/material.dart';

class Carousel3d extends StatefulWidget {
  final int center;
  final List<Widget> items;
  final Duration duration;
  final int displayRadius;

  const Carousel3d(
      {Key? key,
      required this.center,
      required this.items,
      this.duration = const Duration(milliseconds: 200),
      this.displayRadius = 2,})
      : super(key: key);

  @override
  State<Carousel3d> createState() => _Carousel3dState();
}

class _Carousel3dState extends State<Carousel3d> {
  late List<CarouselItem> children;
  int lastCenter = 0;

  @override
  void initState() {
    final len = widget.items.length;
    children = widget.items
        .asMap()
        .entries
        .map((e) => CarouselItem(
              key: Key(e.key.toString()),
              index: e.key,
              widget: e.value,
              length: len,
              duration: widget.duration,
              displayRadius: widget.displayRadius,
            ))
        .toList();
    sort();
    lastCenter = widget.center;
    super.initState();
  }

  void sort() {
    children.sort((a, b) =>
        a.getRadius(widget.center).compareTo(b.getRadius(widget.center)) * -1);
  }

  @override
  Widget build(BuildContext context) {
    final center = widget.center % widget.items.length;
    if (lastCenter != center) {
      sort();
      setState(() {
        lastCenter = center;
      });
    }
    return CarouselContext(
      center: widget.center % widget.items.length,
      length: widget.items.length,
      displayRadius: widget.displayRadius,
      child: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: children,
      ),
    );
  }
}

class CarouselContext extends InheritedWidget {
  const CarouselContext(
      {Key? key,
      required this.center,
      required this.length,
      required this.displayRadius,
      required Widget child})
      : super(key: key, child: child);

  final int center;
  final int length;
  final int displayRadius;

  static CarouselContext of(BuildContext context) {
    final CarouselContext? result =
        context.dependOnInheritedWidgetOfExactType<CarouselContext>();
    assert(result != null, 'No CenterIndex found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(CarouselContext oldWidget) =>
      center != oldWidget.center ||
      length != oldWidget.length ||
      displayRadius != oldWidget.displayRadius;
}

class CarouselItem extends StatelessWidget {
  final Widget widget;
  final int index;
  final int length;
  final Duration duration;
  final int displayRadius;

  int getRadius(int center) {
    final dist = (index - center) % length;
    return dist <= length ~/ 2 ? dist : length - dist;
  }

  const CarouselItem({
    Key? key,
    required this.index,
    required this.widget,
    required this.length,
    required this.duration,
    required this.displayRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext innerContext) {
      final carousel = CarouselContext.of(innerContext);
      final radius = getRadius(carousel.center);
      final isShown = radius <= carousel.displayRadius;
      final isNext = radius == carousel.displayRadius + 1;
      final double direction =
          (carousel.center + radius) % length == index ? 1 : -1;

      final double newTop =
          (isShown ? (length / 2 - radius) : displayRadius) * 5;
      final double newLeft = 100 +
          (isShown ? radius * direction : displayRadius * direction) * 70 / 1.5;

      return AnimatedPositioned(
        top: newTop,
        left: newLeft,
        duration: duration,
        child: AnimatedOpacity(
          duration: duration,
          opacity: isShown || isNext ? 1 : 0,
            child: widget,
          ),
        // ),
      );
    });
  }
}

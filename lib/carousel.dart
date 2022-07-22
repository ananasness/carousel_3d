import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Carousel extends StatefulWidget {
  final int center;

  final List<Widget> items;

  const Carousel({Key? key, required this.center, required this.items})
      : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

const duration = Duration(milliseconds: 200);
const displayRadius = 2;

class StackItem extends StatefulWidget {
  final Widget widget;
  final int index;
  final int length;

  int getRadius(int center) {
    final dist = (index - center) % length;
    return dist <= length ~/ 2 ? dist : length - dist;
  }

  StackItem(
      {Key? key,
      required this.index,
      required this.widget,
      required this.length})
      : super(key: key);

  @override
  State<StackItem> createState() => _StackItemState();
}

class _StackItemState extends State<StackItem> {
  double? top;
  double? left;

  // @override
  // void initState() {
  //   top = 0;
  //   left = 0;
  //   super.initState();
  // }

  // void updatePosition(CarouselContext carousel) {
  //   print(carousel.center);
  //   print(widget.length);
  //   // final direction = index % 2 == 0 ? 1 : -1;
  //   // final radius = widget.getRadius(carousel.center);
  //   // final isShown = radius <= carousel.displayRadius;
  //   // final direction =
  //   //     (carousel.center + radius) % widget.length == widget.index ? 1 : -1;
  //   // print('index: ${widget.index}, ${isShown}, ${radius}, ${direction}');
  //   // final newTop = (isShown ? radius : displayRadius) * 10;
  //   // final newLeft = 100 + (isShown ? radius * direction : displayRadius) * 90;
  //   if (newTop != top || newLeft != left) {
  //     setState(() {
  //       top = newTop + 0.0;
  //       left = newLeft + 0.0;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext innerContext) {
      final carousel = CarouselContext.of(innerContext);
      final radius = widget.getRadius(carousel.center);
      final isShown = radius <= carousel.displayRadius;
      final isNext = radius == carousel.displayRadius + 1;
      final double direction =
          (carousel.center + radius) % widget.length == widget.index ? 1 : -1;
      print('index: ${widget.index}, ${isShown}, ${radius}, ${direction}');
      final double newTop = (isShown ? (widget.length / 2 - radius) : displayRadius) * 5;
      final double newLeft =
          100 + (isShown ? radius * direction : displayRadius * direction) * 70 / 1.5;

      return AnimatedPositioned(
        top: newTop,
        left: newLeft,
        duration:  duration,
        child: AnimatedOpacity(
          duration: duration,
          opacity: isShown || isNext ? 1 : 0,
          child: Container(
            width: 70,
            height: 100,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.elliptical(20, 16))),
            child: widget.widget,
          ),
        ),
      );
    });

    throw UnimplementedError();
  }
}

class CarouselContext extends InheritedWidget {
  const CarouselContext({
    Key? key,
    required this.center,
    required this.length,
    required this.displayRadius,
    required Widget child,
  }) : super(key: key, child: child);

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
  bool updateShouldNotify(CarouselContext old) =>
      center != old.center ||
      length != old.length ||
      displayRadius != old.displayRadius;
}

class _CarouselState extends State<Carousel> {
  // List<Widget> filterIndexesHidden(List<Widget> widgets) {
  //   final start = (widget.center - displayRadius) % widget.items.length;
  //   final end = (widget.center + displayRadius) % widget.items.length;
  //   return widgets.sublist(start, end);
  // }

  // int radius(int index) => (widget.center - index) % widget.items.length;

  late List<StackItem> children;
  int lastCenter = 0;

  // List<Widget> sort(List<Widget> widgets) {
  //   List<Widget> items = [];
  //   int rad = 0;
  //
  //
  //   while (rad <= displayRadius + 1) {
  //     // left
  //     items.add(widget.items[(widget.center - rad) % widget.items.length]);
  //     print(
  //         'rad ${rad}, added index ${(widget.center + rad) %
  //             widget.items.length}');
  //     if (rad != 0) {
  //       // right
  //       items.add(widget.items[(widget.center + rad) % widget.items.length]);
  //       print(
  //           'rad ${rad}, added index ${(widget.center - rad) %
  //               widget.items.length}');
  //     }
  //     rad += 1;
  //   }
  //   return items;
  // }

  @override
  void initState() {
    final len = widget.items.length;
    children = widget.items
        .asMap()
        .entries
        .map((e) => StackItem(
            key: Key(e.key.toString()),
            index: e.key,
            widget: e.value,
            length: len))
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
    // print(widget.center);
    // final start = (widget.center - displayRadius) % widget.items.length;
    // final end = (widget.center + displayRadius) % widget.items.length;

    // final widgets = items.asMap().entries.map((entry) {});

    print('___________________');
    final center = widget.center % widget.items.length;
    print('center ${center}');
    if (lastCenter != center) {
      sort();
      setState(() {
        lastCenter = center;
      });
    }
    print(children.map((e) => e.index));
    return CarouselContext(
      center: widget.center % widget.items.length,
      length: widget.items.length,
      displayRadius: displayRadius,
      child: Stack(
        alignment: AlignmentDirectional.centerStart,
        // index: widget.center % widget.items.length,
        children: children,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:carousel_widget_3d/carousel_widget_3d.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _center = 0;

  void _incrementCounter() {
    setState(() {
      _center++;
    });
  }

  Widget getCard(String path) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.elliptical(20, 16))),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.elliptical(20, 16)),
        child: Image.asset(path, height: 100, width: 100,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Carousel3d(
          center: _center,
          items: [
            getCard('assets/img_1.png'),
            getCard('assets/img_2.png'),
            getCard('assets/img_3.png'),
            getCard('assets/img_4.png'),
            getCard('assets/img_5.png'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.next_plan_outlined),
      ),
    );
  }
}

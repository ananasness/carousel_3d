import 'package:flutter/material.dart';
import 'package:carousel_widget_3d/carousel_widget_3d.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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

Widget getCard(Color color, int n) {
  return Container(
    width: 100,
    height: 200,
    decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.elliptical(20, 16))),
    child: Center(child: Text(n.toString(), style: TextStyle(fontSize: 40),),),
  );
}

class _MyHomePageState extends State<MyHomePage> {
  int _center = 0;

  void _incrementCounter() {
    setState(() {
      _center++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),

      ),
      body: Center(
          child: Carousel3d(center: _center, items: [

            getCard(Colors.red, 0),
            getCard(Colors.green, 1),
            getCard(Colors.yellow, 2),
            getCard(Colors.orange, 3),
            getCard(Colors.blue, 4),
            getCard(Colors.purple, 5),
            getCard(Colors.amberAccent, 6),
            getCard(Colors.tealAccent, 7),
          ],)
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.next_plan_outlined),
      ),
    );
  }
}

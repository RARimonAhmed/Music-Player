import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final players = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: (() {
                players.play(AssetSource('jhoomsong.mp3'));
              }),
              child: const Center(
                child: Text('Play'),
              ),
            ),
            ElevatedButton(
              onPressed: (() {
                players.stop();
              }),
              child: const Center(
                child: Text('Stop'),
              ),
            ),
            ElevatedButton(
              onPressed: (() {
                players.resume();
              }),
              child: const Center(
                child: Text('Resume'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:html';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music Player',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration possition = Duration.zero;

  @override
  void initState() {
    super.initState();
    audioPlayer.onPlayerStateChanged.listen((event) {
      setState(() {
        isPlaying = event == PlayerState.playing;
      });
    });
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        possition = newDuration;
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  String formatter(Duration duration) {
    String minute;
    DateTime datetime = DateTime.now();
    if (duration.inSeconds == 60) {
      minute = datetime.minute.toString();
      return minute;
    } else if (duration.inMinutes == 60) {
      minute = datetime.minute.toString();
      return minute;
    } else {
      return '0';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                'https://images.unsplash.com/photo-1668741932680-5e8c88401bb4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1287&q=80',
                width: double.infinity,
                height: 350,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            const Text(
              'The Flutter Song',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            const Text(
              'Flower song',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Slider(
              min: duration.inSeconds.toDouble(),
              max: duration.inSeconds.toDouble(),
              value: possition.inSeconds.toDouble(),
              onChanged: ((value) async {}),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatter(possition),
                  ),
                  Text(
                    formatter(duration - possition),
                  ),
                ],
              ),
            ),
            CircleAvatar(
              radius: 35,
              child: IconButton(
                onPressed: (() async {
                  if (isPlaying) {
                    await audioPlayer.pause();
                  } else {
                    String url =
                        'https://www.google.com/search?q=how+to+play+a+music+using+rest+api+in+flutter&biw=1280&bih=817&sxsrf=AJOqlzW2PE_LWkaiQOBX8xShcQiBRUWAOw%3A1674143959498&ei=12jJY_CHHr3Ez7sP4eSK8A8&ved=0ahUKEwiwz4iggNT8AhU94nMBHWGyAv44ChDh1QMIDw&uact=5&oq=how+to+play+a+music+using+rest+api+in+flutter&gs_lcp=Cgxnd3Mtd2l6LXNlcnAQAzIECAAQRzIECAAQRzIECAAQR0oECEEYAEoECEYYAFDFElj0KmD_LWgAcAN4AYABAIgBAJIBAJgBAKABAcgBA8ABAQ&sclient=gws-wiz-serp#kpvalbx=_9GjJY8KhGauy3LUPkrG7uAY_50';
                    await audioPlayer.play(url.toString() as Source);
                  }
                }),
                icon: Icon(
                  isPlaying ? Icons.pause_circle : Icons.play_arrow_rounded,
                  color: Colors.red,
                ),
                iconSize: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

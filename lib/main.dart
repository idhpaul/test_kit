import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_libs_audio/media_kit_libs_audio.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
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

  // Create a [Player] to control playback.
  late final player_1 = Player(
    configuration: PlayerConfiguration(
    ready: () {
      print('The initialization is complete.');
    },
    pitch: true,
  ),
  );
  late final player_2 = Player(
    configuration: PlayerConfiguration(
    ready: () {
      print('The initialization is complete.');
    },
    pitch: true,
  ),
  );

  late TextEditingController _volController;
  late TextEditingController _rateController;
  late TextEditingController _pitchController;
  

  @override
  void initState() {
    super.initState();
    _volController = TextEditingController();
    _rateController = TextEditingController();
    _pitchController = TextEditingController();
    player_1.open(Media('asset://assets/audio/original.mp3'),play: false);
    player_2.open(Media('asset://assets/audio/original2.mp3'),play: false);
  }

  @override
  void dispose() {
    _volController.dispose();
    _rateController.dispose();
    _pitchController.dispose();
    player_1.dispose();
    player_2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed: () async {
              await player_1.play();
              await player_2.play();
            }, child: const Text("play")),
            ElevatedButton(onPressed: () async {
              await player_1.pause();
              await player_2.pause();
            }, child: const Text("pause")),
            ElevatedButton(onPressed: () async {
              await player_1.stop();
              await player_2.stop();
              await player_1.open(Media('asset://assets/audio/original.mp3'),play: false);
              await player_2.open(Media('asset://assets/audio/original2.mp3'),play: false);
            }, child: const Text("stop")),


            TextField(
              controller: _volController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'volume',
              ),
            ),
            ElevatedButton(onPressed: () async {

              double value = double.parse(_volController.text);
              await player_1.setVolume(value);
              await player_2.setVolume(value);

            }, child: const Text("set volume")),


            TextField(
              controller: _rateController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'rate',
              ),
            ),
            ElevatedButton(onPressed: () async {

              double value = double.parse(_rateController.text);
              await player_1.setRate(value);
              await player_2.setRate(value);

            }, child: const Text("set rate")),


            TextField(
              controller: _pitchController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'pitch',
              ),
            ),
            ElevatedButton(onPressed: () async {
              
              double value = double.parse(_pitchController.text);
              await player_1.setPitch(value);
              await player_2.setPitch(value);

            }, child: const Text("set pitch")),
          ],
        ),
      ),
    );
  }
}

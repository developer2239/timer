import 'dart:async';

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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'タイマー!'),
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
  int _miliSeconds = 0;

  Timer? _miliSecondsTimer;

  bool _isRunning = false;

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
            Text(
              '$_miliSeconds',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 70,
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: resetTimer,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(40),
                  ),
                  child: const Text(
                    'リセット',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 20,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: toggleTimer,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(40),
                  ),
                  child: Text(
                    _isRunning ? 'ストップ' : 'スタート',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _isRunning ? Colors.red : Colors.green,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void toggleTimer() {
    if (_isRunning) {
      _miliSecondsTimer?.cancel();
    } else {
      _miliSecondsTimer = Timer.periodic(
        const Duration(milliseconds: 1000),
        (timer) {
          setState(() {
            _miliSeconds++;
          });
        },
      );
    }
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  void resetTimer() {
    setState(() {
      _miliSecondsTimer?.cancel();
      _miliSeconds = 0;
      _isRunning = false;
    });
  }
}

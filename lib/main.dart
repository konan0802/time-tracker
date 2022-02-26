import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

import 'ClockTimer.dart';
import 'TaskInfo.dart';
import 'TaskButton.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // 現在の日時表示
              ClockTimer(),
              // タスク表示
              Center(
                child: TaskInfo(),
              ),
              // タスクボタン
              TaskButton(),
            ]),
        backgroundColor: Colors.grey[800],
      ),
    );
  }
}

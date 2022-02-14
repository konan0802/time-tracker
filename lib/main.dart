import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

import 'ClockTimer.dart';
import 'TaskTimer.dart';

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
              ClockTimer(),
              Center(
                child: TaskTimer(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    child: Image.asset('images/break.png'),
                  ),
                  SizedBox(
                    width: 85,
                  ),
                  Container(
                    width: 120,
                    child: Image.asset('images/mtg.png'),
                  ),
                  SizedBox(
                    width: 85,
                  ),
                  Container(
                    width: 120,
                    child: Image.asset('images/other.png'),
                  ),
                ],
              )
            ]),
        backgroundColor: Colors.grey[800],
      ),
    );
  }
}

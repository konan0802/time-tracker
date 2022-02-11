import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft])
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
        brightness: Brightness.dark,
        //scaffoldBackgroundColor: Colors.grey,
      ),
      home: ClockTimer(),
    );
  }
}

class ClockTimer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ClockTimerState();
  }
}

class _ClockTimerState extends State<ClockTimer> {
  /// タイマー文字列用
  String _time = '';

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 1), _onTimer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20),
        child: Text(_time,
            style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w500,
                color: Colors.white)),
      ),
    );
  }

  void _onTimer(Timer timer) {
    var now = DateTime.now();
    var dateFormat = DateFormat('yyyy/MM/dd HH:mm');
    var timeString = dateFormat.format(now);
    setState(() => {_time = timeString});
  }
}

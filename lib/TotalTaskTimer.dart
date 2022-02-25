import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class TotalTaskTimer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TotalTaskTimerState();
  }
}

class _TotalTaskTimerState extends State<TotalTaskTimer> {
  /// タイマー文字列用
  String _name = '';
  String _time = '';
  String _totalTime = '';

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 1), _onTimer);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.0,
      decoration: BoxDecoration(
        border: const Border(
          bottom: const BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "TOTAL",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            Center(
              child: Text(
                "3:24",
                style: TextStyle(
                    fontSize: 47,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          ]),
    );
  }

  void _onTimer(Timer timer) {
    var now = DateTime.now();
    var dateFormat = DateFormat('HH:mm');
    var timeString = dateFormat.format(now);
    if (mounted) {
      setState(() => {_time = timeString});
    }
  }
}

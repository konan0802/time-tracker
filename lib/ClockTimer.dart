import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class ClockTimer extends StatefulWidget {
  const ClockTimer({Key? key}) : super(key: key);

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
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 20, bottom: 5),
      child: Text(_time,
          style: const TextStyle(
              fontSize: 30, fontWeight: FontWeight.w500, color: Colors.white)),
    );
  }

  void _onTimer(Timer timer) {
    var now = DateTime.now();
    var dateFormat = DateFormat('M月d日(E) HH:mm');
    var timeString = dateFormat.format(now);
    if (mounted) {
      setState(() => {_time = timeString});
    }
  }
}

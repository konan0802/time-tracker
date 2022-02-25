import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

import 'TotalTaskTimer.dart';

class TaskTimer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TaskTimerState();
  }
}

class _TaskTimerState extends State<TaskTimer> {
  /// タイマー文字列用
  String _taskName = '';
  String _taskTime = '';
  String _totalTaskTime = '';

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 1), _onTimer);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 580.0,
      padding: EdgeInsets.only(top: 11, left: 10, right: 10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 3.0,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "> develop（API: kwmonitoring）",
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
              ),
              Text(
                _taskTime,
                style: TextStyle(
                    fontSize: 98,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              SizedBox(
                width: 30,
              ),
              TotalTaskTimer(),
            ],
          )
        ],
      ),
    );
  }

  void _onTimer(Timer timer) {
    var now = DateTime.now();
    var dateFormat = DateFormat('HH:mm');
    var timeString = dateFormat.format(now);
    if (mounted) {
      setState(() => {_taskTime = timeString});
    }
  }
}

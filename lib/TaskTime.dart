import 'package:flutter/material.dart';

class TaskTime extends StatefulWidget {
  // TaskInfoからタスクの経過時間を取得
  final String _taskTimeMinutes;
  final String _taskTimeSeconds;
  const TaskTime(this._taskTimeMinutes, this._taskTimeSeconds);

  @override
  State<StatefulWidget> createState() {
    return _TaskTimeState();
  }
}

class _TaskTimeState extends State<TaskTime> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget._taskTimeMinutes,
          style: const TextStyle(
              fontSize: 98, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        const Text(
          ":",
          style: TextStyle(
              fontSize: 98, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        Text(
          widget._taskTimeSeconds.padLeft(2, "0"),
          style: const TextStyle(
              height: 1.45,
              fontSize: 80,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
      ],
    );
  }
}

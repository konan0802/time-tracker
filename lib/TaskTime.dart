import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          style: TextStyle(
              fontSize: 230.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        Text(
          ":",
          style: TextStyle(
              fontSize: 230.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        Text(
          widget._taskTimeSeconds.padLeft(2, "0"),
          style: TextStyle(
              height: 1.45,
              fontSize: 200.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
      ],
    );
  }
}

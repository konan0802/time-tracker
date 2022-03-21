import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TodaysTaskInfo extends StatefulWidget {
  final String _totalTaskTimeHour;
  final String _totalTaskTimeMinutes;
  const TodaysTaskInfo(this._totalTaskTimeHour, this._totalTaskTimeMinutes);

  @override
  State<StatefulWidget> createState() {
    return _TodaysTaskInfoState();
  }
}

class _TodaysTaskInfoState extends State<TodaysTaskInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white,
            width: 2.0.w,
          ),
        ),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Today",
              style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget._totalTaskTimeHour,
                  style: TextStyle(
                      fontSize: 52.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                Text(
                  "h",
                  style: TextStyle(
                      height: 1.8.h,
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                Text(
                  widget._totalTaskTimeMinutes.padLeft(2, "0"),
                  style: TextStyle(
                      fontSize: 52.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                Text(
                  "m",
                  style: TextStyle(
                      height: 1.8.h,
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ],
            )
          ]),
    );
  }
}

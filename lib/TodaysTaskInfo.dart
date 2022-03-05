import 'package:flutter/material.dart';

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
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              "Today",
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget._totalTaskTimeHour,
                  style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                const Text(
                  "h",
                  style: TextStyle(
                      height: 1.8,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                Text(
                  widget._totalTaskTimeMinutes.padLeft(2, "0"),
                  style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                const Text(
                  "m",
                  style: TextStyle(
                      height: 1.8,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ],
            )
          ]),
    );
  }
}

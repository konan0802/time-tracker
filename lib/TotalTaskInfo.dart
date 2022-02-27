import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class TotalTaskInfo extends StatefulWidget {
  final String _totalTaskTimeHour;
  final String _totalTaskTimeMinutes;
  TotalTaskInfo(this._totalTaskTimeHour, this._totalTaskTimeMinutes);

  @override
  State<StatefulWidget> createState() {
    return _TotalTaskInfoState();
  }
}

class _TotalTaskInfoState extends State<TotalTaskInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.0,
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
              "TOTAL",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget._totalTaskTimeHour,
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                const Text(
                  "h",
                  style: TextStyle(
                      height: 1.8,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                Text(
                  widget._totalTaskTimeMinutes.padLeft(2, "0"),
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                const Text(
                  "m",
                  style: TextStyle(
                      height: 1.8,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ],
            )
          ]),
    );
  }
}

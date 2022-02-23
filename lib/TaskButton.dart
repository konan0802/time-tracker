import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class TaskButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TaskButtonState();
  }
}

class _TaskButtonState extends State<TaskButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
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
    ));
  }
}

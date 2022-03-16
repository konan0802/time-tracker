import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:toggl_pomodoro_app/SubPage.dart';

class Header extends StatefulWidget {
  final String _navType;
  const Header(this._navType);

  @override
  State<StatefulWidget> createState() {
    return _HeaderState();
  }
}

class _HeaderState extends State<Header> {
  /// タイマー文字列用
  String _time = ' ';

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 1), _onTimer);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 3, left: 20, right: 10, bottom: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _time,
            style: const TextStyle(
                fontSize: 30, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          IconButton(
            icon: Image.asset('images/' + widget._navType + '.png'),
            iconSize: 40,
            onPressed: () {
              if (widget._navType == 'push') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SubPage(),
                  ),
                );
              } else if (widget._navType == 'pop') {
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
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

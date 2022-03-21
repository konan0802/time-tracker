import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      margin: EdgeInsets.only(top: 28.h, left: 25.w, right: 25.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _time,
            style: TextStyle(
                fontSize: 80.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
          IconButton(
            icon: Image.asset('images/' + widget._navType + '.png'),
            iconSize: 36.w,
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

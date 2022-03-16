import 'package:flutter/material.dart';
import 'package:toggl_pomodoro_app/Header.dart';

import 'Header.dart';
import 'AsanaTaskList.dart';

class SubPage extends StatelessWidget {
  const SubPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Header('pop'),
          Flexible(child: AsanaTaskList())
        ],
      ),
      backgroundColor: Colors.grey[800],
    );
  }
}

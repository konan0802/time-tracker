import 'package:flutter/material.dart';
import 'package:time_tracker/Header.dart';

import 'Header.dart';
import 'TaskInfo.dart';
import 'TaskButton.dart';

class TopPage extends StatelessWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          // 現在の日時表示
          Header('push'),
          // タスク表示
          Center(
            child: TaskInfo(),
          ),
          // タスクボタン
          TaskButton(),
        ],
      ),
      backgroundColor: Colors.grey[800],
    );
  }
}

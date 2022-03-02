import 'package:flutter/material.dart';

import 'ClockTimer.dart';
import 'TaskInfo.dart';
import 'TaskButton.dart';

class TopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // 現在の日時表示
        const ClockTimer(),
        // タスク表示
        Center(
          child: TaskInfo(),
        ),
        // タスクボタン
        const TaskButton(),
      ],
    );
  }
}

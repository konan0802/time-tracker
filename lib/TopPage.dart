import 'package:flutter/material.dart';

import 'ClockTimer.dart';
import 'TaskInfo.dart';
import 'TaskButton.dart';

class TopPage extends StatelessWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 5, left: 20, bottom: 5),
            child: Row(
              children: [
                // 現在の日時表示
                const ClockTimer(),
                const SizedBox(
                  width: 325,
                ),
                IconButton(
                  icon: Image.asset('images/push.png'),
                  iconSize: 30,
                  onPressed: () {
                    Navigator.of(context).pushNamed("/subpage");
                  },
                ),
              ],
            ),
          ),
          // タスク表示
          Center(
            child: TaskInfo(),
          ),
          // タスクボタン
          const TaskButton(),
        ],
      ),
      backgroundColor: Colors.grey[800],
    );
  }
}

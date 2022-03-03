import 'package:flutter/material.dart';

import 'ClockTimer.dart';

class SubPage extends StatelessWidget {
  const SubPage({Key? key}) : super(key: key);

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
                  icon: Image.asset('images/pop.png'),
                  iconSize: 30,
                  onPressed: () {
                    Navigator.of(context).pushNamed("/toppage");
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey[800],
    );
  }
}

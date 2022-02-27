import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'config.dart';

class TaskButton extends StatefulWidget {
  const TaskButton({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TaskButtonState();
  }
}

class _TaskButtonState extends State<TaskButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Image.asset('images/break.png'),
          iconSize: 123,
          onPressed: () {
            setTogglTask(BreakTime);
          },
        ),
        const SizedBox(
          width: 75,
        ),
        IconButton(
          icon: Image.asset('images/mtg.png'),
          iconSize: 123,
          onPressed: () {
            setTogglTask(MtgTime);
          },
        ),
        const SizedBox(
          width: 75,
        ),
        IconButton(
          icon: Image.asset('images/other.png'),
          iconSize: 123,
          onPressed: () {
            setTogglTask(OtherTime);
          },
        ),
      ],
    );
  }

  Future<void> setTogglTask(String taskName) async {
    String url = 'https://api.track.toggl.com/api/v8/time_entries/start';
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Basic ' +
          base64Encode(utf8.encode(dotenv.env['TOGGL_API_KEY']! + ':api_token'))
    };
    String body = json.encode({
      'time_entry': {
        'description': taskName,
        'pid': dotenv.env['PROJECT_ID'],
        'created_with': 'toggl_pomodoro_app'
      }
    });
    try {
      await http.post(Uri.parse(url), headers: headers, body: body);
    } catch (e) {}
  }
}

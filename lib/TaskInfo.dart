import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'TogglTask.dart';
import 'TogglReport.dart';
import 'TaskTime.dart';
import 'TotalTaskInfo.dart';

class TaskInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TaskInfoState();
  }
}

class _TaskInfoState extends State<TaskInfo> {
  /// タイマー文字列用
  String _taskName = '';
  int _taskTime = 0;
  String _taskTimeMinutes = '';
  String _taskTimeSeconds = '';
  String _totalTaskTimeHour = '';
  String _totalTaskTimeMinutes = '';

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      fetchTogglTask();
    });

    var lastmonth = DateTime.now().add(Duration(days: 30) * -1);
    var dateFormat = DateFormat('yyyy-MM-dd');
    var timeString = dateFormat.format(lastmonth);
    Timer.periodic(Duration(seconds: 10), (Timer timer) {
      fetchTogglTotalTask(timeString, _taskName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 580.0,
      padding: EdgeInsets.only(top: 11, left: 10, right: 10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 3.0,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "> " + _taskName,
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 55,
              ),
              Container(
                width: 290.0,
                child: TaskTime(_taskTimeMinutes, _taskTimeSeconds),
              ),
              Container(
                padding: EdgeInsets.only(top: 15),
                child: TotalTaskInfo(_totalTaskTimeHour, _totalTaskTimeMinutes),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> fetchTogglTask() async {
    String url = 'https://api.track.toggl.com/api/v8/time_entries/current';
    final response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Authorization": 'Basic ' +
          base64Encode(utf8.encode(dotenv.env['TOGGL_API_KEY']! + ':api_token'))
    });
    try {
      TogglTask togglTask =
          TogglTask.fromJson(jsonDecode(response.body)["data"]);

      // タスク経過時間 = 現在の時刻 - タスクの開始時刻
      var now = DateTime.now();
      var start = DateTime.parse(togglTask.start);
      _taskTime = now.difference(start).inSeconds;
      var durationM = _taskTime ~/ 60;
      var durationS = _taskTime % 60;
      setState(() {
        _taskTimeMinutes = durationM == null ? "?" : durationM.toString();
        _taskTimeSeconds = durationS == null ? "?" : durationS.toString();
        _taskName = togglTask.description;
      });
    } catch (e) {
      setState(() {
        _taskTimeMinutes = "?";
        _taskTimeSeconds = "??";
        _taskName = "[No current task]";
      });
    }
  }

  Future<void> fetchTogglTotalTask(String lastmonth, String taskName) async {
    if (taskName == 'MTGタスク' ||
        taskName == '開発部 全般タスク' ||
        taskName == 'その他(工数見積・サポート)' ||
        taskName == '全社タスク(開発関係以外)' ||
        taskName == '【昼休憩】※ 予定OK' ||
        taskName == 'Give me a break !!') {
      setState(() {
        _totalTaskTimeHour = "--";
        _totalTaskTimeMinutes = "--";
      });
      return;
    }
    String url = 'https://api.track.toggl.com/reports/api/v2/details';
    url +=
        '?workspace_id=${dotenv.env['WORKSPACE_ID']}&since=${lastmonth}&user_agent=konanforbis@gmail.com&description=${taskName}';
    final response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Authorization": 'Basic ' +
          base64Encode(utf8.encode(dotenv.env['TOGGL_API_KEY']! + ':api_token'))
    });
    List<TogglReport> togglReport = [];
    try {
      final List<dynamic> responsedTogglReport =
          jsonDecode(utf8.decode(response.body.runes.toList()))['data'];
      togglReport = responsedTogglReport
          .map((responsedTogglReport) =>
              TogglReport.fromJson(responsedTogglReport))
          .toList();

      int total = 0;
      for (int i = 0; i < togglReport.length; i++) {
        total += togglReport[i].dur;
      }
      var duration = ((total * 0.001) + _taskTime) * 0.017;
      var durationH = duration ~/ 60;
      var durationM = (duration % 60).floor();
      setState(() {
        _totalTaskTimeHour = durationH.toString();
        _totalTaskTimeMinutes = durationM.toString();
      });
    } catch (e) {
      setState(() {
        _totalTaskTimeHour = "?";
        _totalTaskTimeMinutes = "??";
      });
    }
  }
}

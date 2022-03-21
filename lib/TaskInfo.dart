import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'TogglTask.dart';
import 'TogglReport.dart';
import 'TaskTime.dart';
import 'TodaysTaskInfo.dart';
import 'TotalTaskInfo.dart';
import 'config.dart';

class TaskInfo extends StatefulWidget {
  const TaskInfo({Key? key}) : super(key: key);

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
  String _todaysTaskTimeHour = '';
  String _todaysTaskTimeMinutes = '';
  String _totalTaskTimeHour = '';
  String _totalTaskTimeMinutes = '';

  int _taskInfoCllorR = 66;
  int _taskInfoCllorG = 66;
  int _taskInfoCllorB = 66;

  @override
  void initState() {
    super.initState();

    // 現在タスクの管理
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      fetchTogglTask();
    });

    var dateFormat = DateFormat('yyyy-MM-dd');

    // タスクの当日時間の管理
    var today = DateTime.now();
    var todayStr = dateFormat.format(today);
    Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      fetchTodaysTogglTaskTime(todayStr, _taskName);
    });

    // タスクのトータル時間の管理
    var lastmonth = DateTime.now().add(const Duration(days: 30) * -1);
    var totalStr = dateFormat.format(lastmonth);
    Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      fetchTogglTotalTask(totalStr, _taskName);
    });

    // アラート管理
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      manageTaskInfoColor();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 640.w,
      height: 530.h,
      padding: EdgeInsets.only(top: 60.h, left: 15.w, right: 20.w),
      margin: EdgeInsets.only(top: 35.h, bottom: 28.h),
      decoration: BoxDecoration(
        color: Color.fromARGB(
          255,
          _taskInfoCllorR,
          _taskInfoCllorG,
          _taskInfoCllorB,
        ),
        border: Border.all(
          color: Colors.white,
          width: 3.0.w,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 74.sp,
                  padding: EdgeInsets.only(left: 8.w),
                  child: Text(
                    _taskName,
                    style: TextStyle(
                      fontSize: 57.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  height: 60.h,
                ),
                Container(
                  width: 355.w,
                  margin: EdgeInsets.only(left: 58.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TaskTime(_taskTimeMinutes, _taskTimeSeconds),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 15.w,
          ),
          Container(
            width: 100.w,
            margin: EdgeInsets.only(bottom: 10.h, right: 25.w),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 120.h),
                  child: TodaysTaskInfo(
                      _todaysTaskTimeHour, _todaysTaskTimeMinutes),
                ),
                Container(
                  padding: EdgeInsets.only(top: 50.h),
                  child:
                      TotalTaskInfo(_totalTaskTimeHour, _totalTaskTimeMinutes),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> fetchTogglTask() async {
    String url = 'https://api.track.toggl.com/api/v8/time_entries/current';
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Basic ' +
          base64Encode(utf8.encode(dotenv.env['TOGGL_API_KEY']! + ':api_token'))
    };
    final response = await http.get(Uri.parse(url), headers: headers);
    // 一時的な[Too Many Requests]のレスポンスは握り潰す
    if (response.statusCode == 429) {
      return;
    }
    try {
      TogglTask togglTask =
          TogglTask.fromJson(jsonDecode(response.body)["data"]);

      // タスク経過時間 = 現在の時刻 - タスクの開始時刻
      var now = DateTime.now();
      var start = DateTime.parse(togglTask.start);
      _taskTime = now.difference(start).inSeconds;
      var durationM = _taskTime ~/ 60;
      var durationS = _taskTime % 60;
      if (mounted) {
        setState(() {
          _taskTimeMinutes = durationM == null ? "?" : durationM.toString();
          _taskTimeSeconds = durationS == null ? "?" : durationS.toString();
          _taskName = togglTask.description;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _taskTimeMinutes = "?";
          _taskTimeSeconds = "??";
          _taskName = NoTask;
        });
      }
    }
  }

  Future<void> fetchTogglTotalTask(String lastmonth, String taskName) async {
    if (isCheckFixedTasks(taskName)) {
      if (mounted) {
        setState(() {
          _totalTaskTimeHour = "--";
          _totalTaskTimeMinutes = "--";
        });
      }
      return;
    }
    String url = 'https://api.track.toggl.com/reports/api/v2/details';
    url += '?workspace_id=${dotenv.env['WORKSPACE_ID']}';
    url += '&since=$lastmonth';
    url += '&user_agent=konanforbis@gmail.com';
    url += '&description=$taskName';
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Basic ' +
          base64Encode(utf8.encode(dotenv.env['TOGGL_API_KEY']! + ':api_token'))
    };
    final response = await http.get(Uri.parse(url), headers: headers);
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
      var duration = ((total * 0.001) + _taskTime) * 0.016666666666667;
      var durationH = duration ~/ 60;
      var durationM = (duration % 60).floor();
      if (mounted) {
        setState(() {
          _totalTaskTimeHour = durationH.toString();
          _totalTaskTimeMinutes = durationM.toString();
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _totalTaskTimeHour = "?";
          _totalTaskTimeMinutes = "??";
        });
      }
    }
  }

  Future<void> fetchTodaysTogglTaskTime(
      String startTime, String taskName) async {
    if (isCheckFixedTasks(taskName)) {
      if (mounted) {
        setState(() {
          _todaysTaskTimeHour = "--";
          _todaysTaskTimeMinutes = "--";
        });
      }
      return;
    }
    String url = 'https://api.track.toggl.com/reports/api/v2/details';
    url += '?workspace_id=${dotenv.env['WORKSPACE_ID']}';
    url += '&since=$startTime';
    url += '&user_agent=konanforbis@gmail.com';
    url += '&description=$taskName';
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Basic ' +
          base64Encode(utf8.encode(dotenv.env['TOGGL_API_KEY']! + ':api_token'))
    };
    final response = await http.get(Uri.parse(url), headers: headers);
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
      var duration = ((total * 0.001) + _taskTime) * 0.016666666666667;
      var durationH = duration ~/ 60;
      var durationM = (duration % 60).floor();
      if (mounted) {
        setState(() {
          _todaysTaskTimeHour = durationH.toString();
          _todaysTaskTimeMinutes = durationM.toString();
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _todaysTaskTimeHour = "?";
          _todaysTaskTimeMinutes = "??";
        });
      }
    }
  }

  /*
    アラート条件
    ・タスクなし:  アラート
    ・MtgTime:   アラートなし
    ・BreakTime: 60分以上でアラート
    ・上記以外:    25分以上でアラート
  */
  void manageTaskInfoColor() {
    if (_taskName == NoTask) {
      if (mounted) {
        setState(() {
          _taskInfoCllorR = 191;
          _taskInfoCllorG = 67;
          _taskInfoCllorB = 67;
        });
      }
    } else if (_taskName == BreakTime && _taskTime >= 3600) {
      if (mounted) {
        setState(() {
          _taskInfoCllorR = 191;
          _taskInfoCllorG = 67;
          _taskInfoCllorB = 67;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          _taskInfoCllorR = 66;
          _taskInfoCllorG = 66;
          _taskInfoCllorB = 66;
        });
      }
    }
  }

  bool isCheckFixedTasks(String taskName) {
    for (int j = 0; j < fexedTasks.length; j++) {
      if (taskName == fexedTasks[j]) {
        return true;
      }
    }
    return false;
  }
}

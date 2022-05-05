import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'AsanaTask.dart';
import 'config.dart';

class AsanaAPI {
  AsanaAPI();

  Future<void> setTogglTask(String taskName) async {
    String url = 'https://api.track.toggl.com/api/v8/time_entries/start';
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Basic ' +
          base64Encode(utf8.encode(dotenv.env['TOGGL_API_KEY']! + ':api_token'))
    };
    String body = json.encode({
      'time_entry': {'description': taskName, 'created_with': 'time_tracker'}
    });
    http.Response resp =
        await http.post(Uri.parse(url), headers: headers, body: body);
    if (resp.statusCode != 200) {
      print(resp.body);
    }
  }

  /// @request  [1234, 5678]
  /// @response [{section: Main, task: []}, {section: Main, task: []}]
  Future<List<Map<String, dynamic>>> fetchAsanaTaskstFromSectioons(
      List<String> sectionIDs) async {
    List<Map<String, dynamic>> asanaTaskList = [];
    for (int i = 0; i < sectionIDs.length; i++) {
      var res = await fetchAsanaTaskstFromSectioon(sectionIDs[i]);
      var sectionName = SectionIDs.keys.firstWhere(
          (key) => SectionIDs[key] == sectionIDs[i],
          orElse: () => 'Null');
      for (int j = 0; j < res.length; j++) {
        Map<String, dynamic> result = {
          'section': sectionName,
          'task': res[j].name,
          'due_on': res[j].dueOn,
        };
        asanaTaskList.add(result);
      }
    }
    return Future<List<Map<String, dynamic>>>.value(asanaTaskList);
  }

  /// @request  [1234, 5678]
  /// @response [{section: Main, task: []}, {section: Main, task: []}]
  Future<List<Map<String, dynamic>>> fetchAsanaTaskstFromDate(
      DateTime dateTime) async {
    List<Map<String, dynamic>> asanaTaskList = [];
    var res = await fetchAsanaTaskstFromMyTask();
    for (int j = 0; j < res.length; j++) {
      // 期限が入っていないものは対象外
      if (res[j].dueOn == null) {
        continue;
      }
      // 現在日付が、タスク終了日付より後なら'before'とする
      // （≒ 未完了＆過去のタスク）
      DateTime dueOn = DateFormat('yyyy-MM-DD').parse(res[j].dueOn!);
      if (dateTime.isAfter(dueOn)) {
        Map<String, dynamic> result = {
          'group': 'Before',
          'task': res[j].name,
          'start_on': res[j].startOn,
          'due_on': res[j].dueOn,
        };
        asanaTaskList.add(result);
        continue;
      }
      // today判定
      if (dueOn == dateTime) {
        Map<String, dynamic> result = {
          'group': 'Today',
          'task': res[j].name,
          'start_on': res[j].startOn,
          'due_on': res[j].dueOn,
        };
        asanaTaskList.add(result);
        continue;
      }
      if (res[j].startOn != null) {
        DateTime startOn = DateFormat('yyyy-MM-DD').parse(res[j].startOn!);
        if (!dateTime.isBefore(startOn) && !dateTime.isAfter(dueOn)) {
          Map<String, dynamic> result = {
            'group': 'Today',
            'task': res[j].name,
            'start_on': res[j].startOn,
            'due_on': res[j].dueOn,
          };
          asanaTaskList.add(result);
        }
      }
    }
    return Future<List<Map<String, dynamic>>>.value(asanaTaskList);
  }

  Future<List<AsanaTask>> fetchAsanaTaskstFromSectioon(String sectionID) async {
    String url = 'https://app.asana.com/api/1.0/tasks' +
        '?section=' +
        sectionID +
        '&completed_since=now' +
        '&opt_fields=this.name,this.completed,this.due_on';
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer ' + dotenv.env['ASANA_API_KEY']!
    };
    var response = await http.get(Uri.parse(url), headers: headers);
    List<AsanaTask> asanaTaskList = [];
    try {
      final List<dynamic> responsedTogglReport =
          jsonDecode(response.body)['data'];
      asanaTaskList =
          responsedTogglReport.map((i) => AsanaTask.fromJson(i)).toList();
      return asanaTaskList;
    } catch (e) {
      print(response.body);
      rethrow;
    }
  }

  Future<List<AsanaTask>> fetchAsanaTaskstFromMyTask() async {
    String url = 'https://app.asana.com/api/1.0/tasks' +
        '?project=' +
        MyTask +
        '&completed_since=now' +
        '&opt_fields=this.name,this.completed,this.start_on,this.due_on';
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer ' + dotenv.env['ASANA_API_KEY']!
    };
    var response = await http.get(Uri.parse(url), headers: headers);
    List<AsanaTask> asanaTaskList = [];
    try {
      final List<dynamic> responsedTogglReport =
          jsonDecode(response.body)['data'];
      asanaTaskList =
          responsedTogglReport.map((i) => AsanaTask.fromJson(i)).toList();
      return asanaTaskList;
    } catch (e) {
      print(response.body);
      rethrow;
    }
  }
}

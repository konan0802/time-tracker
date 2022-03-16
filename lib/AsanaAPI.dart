import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'AsanaTask.dart';
import 'config.dart';

class AsanaAPI {
  AsanaAPI();

  /// @request  [1234, 5678]
  /// @response [{section: Main, task: []}, {section: Main, task: []}]
  Future<List<Map<String, dynamic>>> fetchfetchAsanaTaskstFromSectioons(
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
}

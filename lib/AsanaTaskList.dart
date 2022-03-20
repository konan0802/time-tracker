import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import 'AsanaAPI.dart';

class AsanaTaskList extends StatefulWidget {
  const AsanaTaskList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AsanaTaskListState();
  }
}

class _AsanaTaskListState extends State<AsanaTaskList> {
  // タイマー文字列用
  List<Map<String, dynamic>> _asanaSectionsTasks = [
    {'group': '--', 'task': '--'}
  ];

  @override
  void initState() {
    super.initState();

    final asanaAPI = AsanaAPI();
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    var tmp = asanaAPI.fetchAsanaTaskstFromDate(today);
    tmp.then((value) {
      setState(() => {_asanaSectionsTasks = value});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GroupedListView<dynamic, String>(
      elements: _asanaSectionsTasks,
      groupBy: (element) => element['group'],
      groupComparator: (value1, value2) => value2.compareTo(value1),
      itemComparator: (item1, item2) => item1['task'].compareTo(item2['task']),
      order: GroupedListOrder.ASC,
      //useStickyGroupSeparators: true,
      groupSeparatorBuilder: (String value) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      itemBuilder: (c, element) {
        return Card(
          elevation: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            leading: const Icon(Icons.account_circle),
            title: Text(element['task']),
            trailing: const Icon(Icons.arrow_forward),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        padding: EdgeInsets.all(8.0.w),
        child: Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 50.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ),
      itemBuilder: (c, element) {
        return Card(
          elevation: 8.0,
          color: Colors.grey[300],
          margin: EdgeInsets.symmetric(horizontal: 35.0.w, vertical: 6.0.h),
          child: ListTile(
            leading: IconButton(
              icon: Image.asset('images/icon_round.png'),
              iconSize: 20.h,
              onPressed: () {
                final asanaAPI = AsanaAPI();
                asanaAPI.setTogglTask(element['task']);
              },
            ),
            title: Text(
              element['task'],
              style: TextStyle(
                fontSize: 33.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}

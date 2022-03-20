class AsanaTask {
  final String gid;
  final String name;
  final String? startOn;
  final String? dueOn;
  final bool completed;

  const AsanaTask({
    required this.gid,
    required this.name,
    required this.startOn,
    required this.dueOn,
    required this.completed,
  });

  factory AsanaTask.fromJson(Map<String, dynamic> json) {
    return AsanaTask(
      gid: json['gid'],
      name: json['name'],
      startOn: json['start_on'],
      dueOn: json['due_on'],
      completed: json['completed'],
    );
  }
}

/*
"data": [
    {
        "due_on": "2022-03-15",
        "completed": false,
        "gid": "1201768508846177",
        "name": "ElasticSearch\u306eestimate_size\u4e0a\u6607\u539f\u56e0\u306e\u8abf\u67fb\u3068\u5bfe\u5fdc"
    }, 
    {
        "due_on": null,
        "completed": false,
        "gid": "1201923877912468",
        "name": "test"
    }
]
*/

class TogglTask {
  final String description;
  final String start;

  const TogglTask({
    required this.description,
    required this.start,
  });

  factory TogglTask.fromJson(Map<String, dynamic> json) {
    return TogglTask(
      description: json['description'],
      start: json['start'],
    );
  }
}

/*
"data": {
    "duronly": false, 
    "wid": 5762183, 
    "description": "New time entry", 
    "pid": 175428611, 
    "start": "2022-02-25T22:24:39+00:00", 
    "at": "2022-02-25T22:24:39+00:00", 
    "billable": false, 
    "duration": -1645827879, 
    "id": 2386538672, 
    "uid": 7288804
}
*/

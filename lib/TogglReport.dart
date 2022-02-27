class TogglReport {
  final String description;
  final int dur;

  const TogglReport({
    required this.description,
    required this.dur,
  });

  factory TogglReport.fromJson(Map<String, dynamic> json) {
    return TogglReport(
      description: json['description'],
      dur: json['dur'],
    );
  }
}

/*
{
    "total_count": 14, 
    "total_currencies": [
        {
            "currency": null, 
            "amount": null
        }
    ], 
    "total_billable": null, 
    "total_grand": 63504000, 
    "per_page": 50, 
    "data": [
        {
            "updated": "2022-02-10T12:23:06+09:00", 
            "task": null, 
            "end": "2022-02-10T11:20:46+09:00", 
            "description": "MTG\u30bf\u30b9\u30af", 
            "project_color": "0", 
            "tags": [], 
            "is_billable": false, 
            "pid": null, 
            "cur": null, 
            "project": null, 
            "start": "2022-02-10T09:30:46+09:00", 
            "client": null, 
            "user": "\u5c0f\u5357\u4f51\u4ecb", 
            "billable": null, 
            "tid": null, 
            "project_hex_color": null, 
            "dur": 6600000, 
            "use_stop": true, 
            "id": 2363314011, 
            "uid": 7288804
        }, 
        {
            "updated": "2022-02-09T10:45:32+09:00", 
            "task": null, 
            "end": "2022-02-09T10:45:31+09:00", 
            "description": "MTG\u30bf\u30b9\u30af", 
            "project_color": "0", 
            "tags": [], 
            "is_billable": false, 
            "pid": null, 
            "cur": null, 
            "project": null, 
            "start": "2022-02-09T09:59:21+09:00", 
            "client": null, 
            "user": "\u5c0f\u5357\u4f51\u4ecb", 
            "billable": null, 
            "tid": null, 
            "project_hex_color": null, 
            "dur": 2770000, 
            "use_stop": true, 
            "id": 2361392409, 
            "uid": 7288804
        }
*/
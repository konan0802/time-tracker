import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:toggl_pomodoro_app/SubPage.dart';

import 'TopPage.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: TopPage(),
        backgroundColor: Colors.grey[800],
      ),
      routes: {
        "/toppage": (BuildContext context) => TopPage(),
        "/subpage": (BuildContext context) => SubPage(),
      },
    );
  }
}

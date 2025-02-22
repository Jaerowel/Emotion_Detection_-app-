import 'package:flutter/material.dart';
import 'home.dart';
import 'package:camera/camera.dart';

List<CameraDescription>? cameras;
void main()async {
  WidgetsFlutterBinding .ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'camera app',
      theme: ThemeData(
          primarySwatch: Colors.blue),
      home: const Home(),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

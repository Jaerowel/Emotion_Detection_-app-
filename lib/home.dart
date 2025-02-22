  import 'package:flutter/material.dart';

  import 'components/camera_widget.dart';
  import 'components/capture_button.dart';
  import 'components/emotion_detector_controller.dart';
  import 'components/emotion_text.dart';


  class Home extends StatefulWidget {
    const Home({Key? key}) : super(key: key);

    @override
    _HomeState createState() => _HomeState();
  }

  class _HomeState extends State<Home> {
    final EmotionDetectorController _controller = EmotionDetectorController();

    @override
    void initState() {
      super.initState();
      _controller.loadModel();
      _controller.initializeCamera().then((_) {
        setState(() {}); // Refresh UI once camera is initialized
      });
    }

    @override
    void dispose() {
      _controller.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text("Emotion Detector")),
        body: Column(
          children: [
            CameraWidget(controller: _controller.cameraController),
            CaptureButton(onCapture: _controller.captureAndAnalyzeImage),
            SizedBox(height: 20),
            EmotionText(output: _controller.output),
          ],
        ),
      );
    }
  }

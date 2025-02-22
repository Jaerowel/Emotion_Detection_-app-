import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite_v2/tflite_v2.dart';

class EmotionDetectorController {
  CameraController? cameraController;
  ValueNotifier<String> output = ValueNotifier<String>("No Emotion Detected");
  XFile? capturedImage;

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    await cameraController!.initialize();
    await cameraController!.setFlashMode(FlashMode.off); // Ensure flash is off
  }

  Future<void> captureAndAnalyzeImage() async {
    if (cameraController == null || !cameraController!.value.isInitialized) return;

    // Capture image
    capturedImage = await cameraController!.takePicture();

    // Run ML model
    List<dynamic>? results = await Tflite.runModelOnImage(
      path: capturedImage!.path,
      imageMean: 127.5,
      imageStd: 127.5,
      numResults: 2,
      threshold: 0.1,
    );

    if (results != null && results.isNotEmpty) {
      output.value = results[0]['label'];
    }
  }

  Future<void> loadModel() async {
    await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    );
  }

  void dispose() {
    cameraController?.dispose();
    Tflite.close();
  }
}

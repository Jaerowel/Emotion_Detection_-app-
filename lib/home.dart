import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:tflite_v2/tflite_v2.dart'; // Update import for TFLite package

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CameraImage? cameraImage;
  CameraController? cameraController;
  String output = '';

  @override
  void initState() {
    super.initState();
    loadModel();
    setupCamera();
  }

  Future<void> setupCamera() async {
    final cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    await cameraController!.initialize();
    if (!mounted) return;
    setState(() {
      cameraController!.startImageStream((image) {
        cameraImage = image;
        runModel();
      });
    });
  }

  Future<void> runModel() async {
    if (cameraImage == null) return;

    List<dynamic>? results = await Tflite.runModelOnFrame(
      bytesList: cameraImage!.planes.map((plane) {
        return plane.bytes;
      }).toList(),
      imageHeight: cameraImage!.height,
      imageWidth: cameraImage!.width,
      imageMean: 127.5,
      imageStd: 127.5,
      rotation: 90,
      numResults: 2,
      threshold: 0.1,
    );

    if (results != null && results.isNotEmpty) {
      setState(() {
        output = results[0]['label'];
      });
    }
  }

  Future<void> loadModel() async {
    await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    );
  }

  @override
  void dispose() {
    cameraController?.dispose();
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Emotion Detector"),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width,
            child: cameraController == null || !cameraController!.value.isInitialized
                ? Container()
                : AspectRatio(
              aspectRatio: cameraController!.value.aspectRatio,
              child: CameraPreview(cameraController!),
            ),
          ),
          Text(
            output,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}

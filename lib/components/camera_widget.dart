import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraWidget extends StatelessWidget {
  final CameraController? controller;

  const CameraWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width,
      child: controller == null || !controller!.value.isInitialized
          ? Center(child: CircularProgressIndicator())
          : CameraPreview(controller!),
    );
  }
}

import 'package:flutter/material.dart';

class CaptureButton extends StatelessWidget {
  final VoidCallback onCapture;

  const CaptureButton({Key? key, required this.onCapture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onCapture,
      child: Text("Capture & Analyze"),
    );
  }
}

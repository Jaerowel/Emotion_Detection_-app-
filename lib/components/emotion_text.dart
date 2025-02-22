import 'package:flutter/material.dart';

class EmotionText extends StatelessWidget {
  final ValueNotifier<String> output;

  const EmotionText({Key? key, required this.output}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: output,
      builder: (context, value, child) {
        return Text(
          value,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        );
      },
    );
  }
}

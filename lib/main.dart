import 'package:flutter/material.dart';
import 'ocr_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tesseract Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OCRScreen(title: 'OCR App'),
    );
  }
}

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:image_picker/image_picker.dart';

class OCRScreen extends StatefulWidget {
  OCRScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<OCRScreen> {
  String _ocrText = '';
  String path = "";
  bool isLoading = false;

  // Future<void> writeToFile(ByteData data, String path) {
  //   final buffer = data.buffer;
  //   return new File(path).writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  // }

  void pickImage() async {
    // android && ios only
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      path = pickedFile.path;
      _ocr(pickedFile.path);
    }
  }

  void _ocr(uri) async {
    isLoading = true;
    setState(() {});

    _ocrText = await FlutterTesseractOcr.extractText(uri, language: "eng", args: {
      "preserve_interword_spaces": "1",
    });

    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(
                    child: ListView(
                      children: [
                          MaterialButton(
                            child: Text(path.length <= 0?"Add Image":"Change Image", style: TextStyle(color: Colors.white),),
                            color: Colors.blue,
                            onPressed: () { pickImage();
                              },
                          ),

                        path.length <= 0?
                        Container()
                            : Image.file(
                            height: 400,
                            File(path)),
                        isLoading
                            ? Column(children: [CircularProgressIndicator()])
                            : Text(
                          '$_ocrText',
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
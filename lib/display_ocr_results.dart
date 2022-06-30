import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ml_kit_ocr/ml_kit_ocr.dart';

class DisplayOcrResults extends StatefulWidget {
  final String imagePath;
  const DisplayOcrResults({Key? key, required this.imagePath})
      : super(key: key);

  @override
  State<DisplayOcrResults> createState() => _MyAppState();
}

class _MyAppState extends State<DisplayOcrResults> {
  String recognitions = '';
  String timeElapsed = '';
  bool isProcessing = false;
  @override
  Widget build(BuildContext context) {
    // print("Printing recognistionsss" + recognitions);
    if (recognitions == '') {
      getOcrResults();
    }
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Text From Image'),
        ),
        body: getWidget(),
      ),
    );
  }

  Future<void> getOcrResults() async {
    recognitions = '';
    final ocr = MlKitOcr();
    final stopwatch = Stopwatch()..start();
    isProcessing = true;
    setState(() {});
    final result =
        await ocr.processImage(InputImage.fromFilePath(widget.imagePath));
    timeElapsed = stopwatch.elapsedMilliseconds.toString();
    isProcessing = false;
    stopwatch.reset();
    stopwatch.stop();
    for (var blocks in result.blocks) {
      for (var lines in blocks.lines) {
        recognitions += '\n';
        for (var words in lines.elements) {
          recognitions += words.text + ' ';
          for (var temp in words.cornerPoints) {
            if (kDebugMode) {
              print(temp);
            }
          }
        }
      }
    }
    // print(recognitions);
    setState(() {});
  }

  Widget getWidget() {
    if (recognitions.isNotEmpty) {
      setState(() {});
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SelectableText('Recognized Text: $recognitions'),
      );
    } else if (timeElapsed.isNotEmpty) {
      setState(() {});
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Time elapsed: $timeElapsed ms'),
      );
    }
    return Text("No idea Bro");
  }
}

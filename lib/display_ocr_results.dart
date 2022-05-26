// import 'dart:html';
//// import 'package:flutter/cupertino.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:ml_kit_ocr/ml_kit_ocr.dart';

// class DisplayOcrResults extends StatelessWidget {
//   final String imagePath;
//   bool isProcessing = false;
//   String recognitions = '';

//   DisplayOcrResults({super.key, required this.imagePath});

//   @override
//   Widget build(BuildContext context)  {
//     recognitions = await ConvertImageToText(imagePath);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('OCR Output'),
//       ),
//       body:
//     );
//   }

//   Future<String> ConvertImageToText(String imagePath) async {
//     final ocr = MlKitOcr();
//     final stopwatch = Stopwatch()..start();
//     isProcessing = true;
//     final image = InputImage.fromFilePath(imagePath);
//     final result = await ocr.processImage(image);
//     String timeElapsed =
//         stopwatch.elapsedMilliseconds.toString();
//     isProcessing = false;
//     stopwatch.reset();
//     stopwatch.stop();
//     for (var blocks in result.blocks) {
//       for (var lines in blocks.lines) {
//         recognitions += '\n';
//         for (var words in lines.elements) {
//           recognitions += words.text + ' ';
//         }
//       }
//     }
//     return recognitions;
//   }

// }

class DisplayOcrResults extends StatefulWidget {
  final String imagePath;
  const DisplayOcrResults({Key? key, required this.imagePath})
      : super(key: key);

  @override
  State<DisplayOcrResults> createState() => _MyAppState();
}

class _MyAppState extends State<DisplayOcrResults> {
  // XFile? image;
  // String imagePath = widget.imagePath;

  String recognitions = '';
  String timeElapsed = '';
  bool isProcessing = false;
  @override
  Widget build(BuildContext context) {
    print("Printing recognistionsss" + recognitions);
    if (recognitions == '') {
      getOcrResults();
    }
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Text From Image'),
        ),
        // body: ListView(
        body: getWidget(),
        // physics: const ClampingScrollPhysics(),
        // children: [
        // const SizedBox(height: 20),
        // if (image != null)
        //   SizedBox(
        //     height: 200,
        //     width: 200,
        //     child: InteractiveViewer(
        //       child: Image.file(
        //         File(image!.path),
        //         fit: BoxFit.contain,
        //       ),
        //     ),
        //   ),
        // const SizedBox(height: 20),
        //     (() {
        //   if (recognitions.isNotEmpty) {
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: SelectableText('Recognized Text: $recognitions'),
        //     );
        //   }
        //   if (timeElapsed.isNotEmpty) {
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Text('Time elapsed: $timeElapsed ms'),
        //     );
        //   }
        // }())
        // const SizedBox(height: 20),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
        //   children: [
        // ElevatedButton(
        //   onPressed: () async {
        //     image = await ImagePicker()
        //         .pickImage(source: ImageSource.gallery);
        //     recognitions = '';
        //     timeElapsed = '';
        //     setState(() {});
        //   },
        //   child: const Text('Pick Image'),
        // ),
        //         if (image != null)
        //           isProcessing
        //               ? const Center(
        //                   child: CircularProgressIndicator.adaptive(),
        //                 )
        //               : ElevatedButton(
        //                   onPressed: () async {
        //                     recognitions = '';
        //                     final ocr = MlKitOcr();
        //                     final stopwatch = Stopwatch()..start();
        //                     isProcessing = true;
        //                     setState(() {});
        //                     final result = await ocr.processImage(
        //                         InputImage.fromFilePath(image!.path));
        //                     timeElapsed =
        //                         stopwatch.elapsedMilliseconds.toString();
        //                     isProcessing = false;
        //                     stopwatch.reset();
        //                     stopwatch.stop();
        //                     for (var blocks in result.blocks) {
        //                       for (var lines in blocks.lines) {
        //                         recognitions += '\n';
        //                         for (var words in lines.elements) {
        //                           recognitions += words.text + ' ';
        //                         }
        //                       }
        //                     }
        //                     setState(() {});
        //                   },
        //                   child: const Text('Predict from Image'),
        //                 ),
        //       ],
        //     ),
        //   ],
        // ),
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
        }
      }
    }
    print(recognitions);
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

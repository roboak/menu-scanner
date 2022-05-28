import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'take_picture.dart';
import 'package:ml_kit_ocr/ml_kit_ocr.dart';

// A widget that displays the picture taken by the user.
class DisplayProcessedImage extends StatefulWidget {
  final String imagePath;
  const DisplayProcessedImage({super.key, required this.imagePath});

  @override
  ProcessedImageState createState() => ProcessedImageState();
}

class ProcessedImageState extends State<DisplayProcessedImage> {
  bool isTextExtracted = false;
  bool isProcessing = false;
  String timeElapsed = '';
  late ui.Image ImageToBeDisplayedOnCanvas;
  late RecognisedText scanResults;
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Filtered Image')),
        // The image is stored as a file on the device. Use the `Image.file`
        // constructor with the given path to display the image.
        // body: Stack(children: <Widget>[
        //   Container(
        //       // height: MediaQuery.of(context).size.height - 150,
        //       child: Image.file(File(widget.imagePath))),
        //   // Image.file(File(widget.imagePath)),
        //   _buildResults()
        // ])
        body: _buildResults());
  }

  Future<void> getOcrResults() async {
    // String recognitions = '';
    final ocr = MlKitOcr();
    final stopwatch = Stopwatch()..start();
    isProcessing = true;
    // setState(() {});
    scanResults =
        await ocr.processImage(InputImage.fromFilePath(widget.imagePath));
    timeElapsed = stopwatch.elapsedMilliseconds.toString();
    isProcessing = false;
    stopwatch.reset();
    stopwatch.stop();
    await _loadImage(File(widget.imagePath));
    isTextExtracted = true;
    // print("Set State called");
    setState(() {});
  }

  Widget _buildResults() {
    CustomPainter painter;
    // print(scanResults);
    if (isTextExtracted == false) {
      getOcrResults();
    }
    // final image = InputImage.fromFilePath(widget.imagePath);

    if (isProcessing == false && isTextExtracted == true) {
      painter = TextDetectorPainter(scanResults, ImageToBeDisplayedOnCanvas);
      return FittedBox(
          child: SizedBox(
        width: ImageToBeDisplayedOnCanvas.width.toDouble(),
        height: ImageToBeDisplayedOnCanvas.height.toDouble(),
        child: CustomPaint(
          painter: painter,
        ),
      ));
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  Future<void> _loadImage(File file) async {
    final data = await file.readAsBytes();
    ImageToBeDisplayedOnCanvas = await decodeImageFromList(data);
  }
}

class TextDetectorPainter extends CustomPainter {
  // TextDetectorPainter(this.absoluteImageSize, this.recognisedText);
  TextDetectorPainter(this.recognisedText, this.image);

  // final Size absoluteImageSize;
  ui.Image image;
  final RecognisedText recognisedText;

  @override
  void paint(Canvas canvas, Size size) {
    // final double scaleX = size.width / absoluteImageSize.width;
    // final double scaleY = size.height / absoluteImageSize.height;
    canvas.drawImage(image, Offset.zero, Paint());
    // Rect scaleRect(TextElement text) {
    //   return Rect.fromPoints(
    //     text.cornerPoints[0] * scaleX,
    //     text.cornerPoints[3] * scaleY,
    //   );
    // }

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement element in line.elements) {
          paint.color = Colors.green;
          canvas.drawRect(element.rect, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(TextDetectorPainter oldDelegate) {
    return oldDelegate.recognisedText != recognisedText;
  }
}

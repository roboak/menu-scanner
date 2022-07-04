import 'dart:io';
import 'package:flutter/material.dart';
import 'package:menu_scanner/utils.dart';
import 'dart:ui' as ui;
import 'package:ml_kit_ocr/ml_kit_ocr.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'globals.dart' as globals;
import 'email_sender.dart';

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
  List<String>? filter;
  late ui.Image ImageToBeDisplayedOnCanvas;
  late RecognisedText scanResults;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Filtered Image')),
        body: _buildResults(),
        floatingActionButton: ElevatedButton(
          onPressed: () async {
            // When this button is clicked display filtered image with a button to go back to the capturing page.
            try {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EmailSenderWidget(),
                ),
              );
            } catch (e) {
              // If an error occurs, log the error to the console.
              print(e);
            }
          },
          child: const Text('Report Issue'),
        ));
  }

  Future<void> preprocess() async {
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

    //loading image which will be displayed
    await _loadImage(File(widget.imagePath));

    //loading user's choice from shared preference
    final datsource = await globals.perferenceInstance;
    filter = datsource.getStringList("eat_preferences");
    Utils ut = Utils();
    await ut.loadDict();
    isTextExtracted = true;
    // print("Set State called");
    setState(() {});
  }

  Widget _buildResults() {
    CustomPainter painter;
    // print(scanResults);
    if (isTextExtracted == false) {
      preprocess();
    }
    // final image = InputImage.fromFilePath(widget.imagePath);

    if (isProcessing == false && isTextExtracted == true) {
      painter =
          TextDetectorPainter(scanResults, ImageToBeDisplayedOnCanvas, filter!);

      return FittedBox(
          child: InteractiveViewer(
              panEnabled: true,
              boundaryMargin: const EdgeInsets.all(100),
              minScale: 0.5,
              maxScale: 2,
              child: SizedBox(
                width: ImageToBeDisplayedOnCanvas.width.toDouble(),
                height: ImageToBeDisplayedOnCanvas.height.toDouble(),
                child: CustomPaint(
                  painter: painter,
                ),
              )));
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  Future<void> _loadImage(File file) async {
    final data = await file.readAsBytes();
    ImageToBeDisplayedOnCanvas = await decodeImageFromList(data);
  }
}

class TextDetectorPainter extends CustomPainter {
  // TextDetectorPainter(this.absoluteImageSize, this.recognisedText);
  ui.Image image;
  final RecognisedText recognisedText;
  List<String> filter;

  TextDetectorPainter(this.recognisedText, this.image, this.filter) {}
  late SharedPreferences prefs;

  // final Size absoluteImageSize;

  final textStyle = const TextStyle(
    color: Color.fromARGB(255, 246, 6, 6),
    fontSize: 25,
  );

  @override
  void paint(Canvas canvas, Size size) async {
    canvas.drawImage(image, Offset.zero, Paint());
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement element in line.elements) {
          paint.color = Colors.red;

          // Filter check based on user preferences.
          print("printing filter: $filter");
          Utils utils = Utils();
          if (filter.contains("Vegan")) {
            if (utils.isVegan(element.text, line.recognizedLanguages)){
              canvas.drawRect(element.rect, paint);
            }
          } else if (filter.contains("Vegetarian")) {
            if (utils.isVegetarian(element.text, line.recognizedLanguages)){
              canvas.drawRect(element.rect, paint);
            }
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(TextDetectorPainter oldDelegate) {
    return oldDelegate.recognisedText != recognisedText;
  }
}

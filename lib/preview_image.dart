import 'dart:io';
import 'package:flutter/material.dart';
import 'display_ocr_results.dart';
import 'display_processed_image.dart';

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Preview Image')),
        // The image is stored as a file on the device. Use the `Image.file`
        // constructor with the given path to display   the image.
        body: Image.file(File(imagePath)),
        floatingActionButton: ElevatedButton(
          onPressed: () async {
            // When this button is clicked display filtered image with a button to go back to the capturing page.
            try {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DisplayProcessedImage(
                    imagePath: imagePath,
                  ),
                ),
              );
            } catch (e) {
              // If an error occurs, log the error to the console.
              print(e);
            }
          },
          child: const Text('Filter Food'),
        ));
  }
}

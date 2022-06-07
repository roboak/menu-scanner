import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'take_picture.dart';
import 'globals.dart' as globals;

class DynamicCheckbox extends StatefulWidget {
  const DynamicCheckbox({Key? key}) : super(key: key);

  @override
  DynamicCheckboxState createState() => DynamicCheckboxState();
}

class DynamicCheckboxState extends State {
  // TODO Save these values in memory s.t. they can be accessed later on again
  Map<String, bool?> list = {
    'Vegan': false,
    'Vegetarian': false,
    'Non-Vegetarian': false,

    // 'Tomatoes': false,
    // 'Onions': false,
    // 'Peanuts': false,
  };

  savePreferences() async {
    List<String> holder_1 = [];
    list.forEach((key, value) {
      if (value == true) {
        holder_1.add(key);
      }
    });

    // Printing all selected items on Terminal screen.
    print(holder_1);
    // Here you will get all your selected Checkbox items.
    final SharedPreferences prefs = await globals.perferenceInstance;
    prefs.setStringList('preferences', holder_1);
    // Clear array after use.
    holder_1.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Expanded(
        child: ListView(
          children: list.keys.map((String key) {
            return CheckboxListTile(
              title: Text(key),
              value: list[key],
              activeColor: Colors.teal,
              checkColor: Colors.white,
              onChanged: (bool? value) {
                setState(() {
                  list[key] = value;
                });
                savePreferences();
              },
            );
          }).toList(),
        ),
      ),
      // TODO Make button more visible
      ElevatedButton(
        onPressed: () async {
          WidgetsFlutterBinding.ensureInitialized();
          // Obtain a list of the available cameras on the device.
          final cameras = await availableCameras();

          // Get a specific camera from the list of available cameras.
          final firstCamera = cameras.first;

          try {
            await Navigator.of(context).push(
              // TODO Not sure how to route this properly
              MaterialPageRoute(
                builder: (context) => TakePictureScreen(
                  camera: firstCamera,
                ),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
        child: const Text('Scan menu'),
      ),
    ]);
  }
}

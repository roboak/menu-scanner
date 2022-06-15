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
  Map<String, bool?> list1 = {
    'Non-Vegetarian': false,
    'Vegan': false,
    'Vegetarian': false,
    'Gluten-free': false,
    'Dairy-free': false,
    'Nut-free': false,
  };

  Map<String, bool?> list2 = {
    'Meat': false,
    'Dairy': false,
    'Eggs': false,
    'Gluten': false,
  };

  savePreferences() async {
    List<String> holder_1 = [];
    List<String> holder_2 = [];

    list1.forEach((key, value) {
      if (value == true) {
        holder_1.add(key);
      }
    });

    list2.forEach((key, value) {
      if (value == true) {
        holder_2.add(key);
      }
    });

    // Printing all selected items on Terminal screen.
    print(holder_1);
    // Here you will get all your selected Checkbox items.
    final SharedPreferences prefs1 = await globals.perferenceInstance;
    prefs1.setStringList('eat_preferences', holder_1);
    // Clear array after use.
    holder_1.clear();

    final SharedPreferences prefs2 = await globals.perferenceInstance;
    prefs2.setStringList('avoid_preferences', holder_2);
    // Clear array after use.
    holder_2.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Expanded(
        child: ListView(
          children: list1.keys.map((String key) {
            return CheckboxListTile(
              title: Text(key),
              value: list1[key],
              activeColor: Colors.teal,
              checkColor: Colors.white,
              onChanged: (bool? value) {
                setState(() {
                  list1[key] = value;
                });
                savePreferences();
              },
            );
          }).toList(),
        ),
      ),
      Container(
        color: Colors.teal,
        //margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(10),
        width: 500,
        height: 60,
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("  What do you not want to eat?",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'RobotoMono',
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
      Expanded(
        child: ListView(
          children: list2.keys.map((String key) {
            return CheckboxListTile(
              title: Text(key),
              value: list2[key],
              activeColor: Colors.teal,
              checkColor: Colors.white,
              onChanged: (bool? value) {
                setState(() {
                  list2[key] = value;
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

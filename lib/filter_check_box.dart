import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'take_picture.dart';
import 'globals.dart' as globals;

class FoodPreference {
  String name;
  String image;
  bool isCheck;
  FoodPreference(this.name, this.image, this.isCheck);
}

class DynamicCheckbox extends StatefulWidget {
  const DynamicCheckbox({super.key});

  @override
  DynamicCheckboxState createState() => DynamicCheckboxState();
}

class DynamicCheckboxState extends State {
  final keyIsFirstLoaded = 'is_first_loaded';
  Map<String, FoodPreference> list1 = {
    'Vegan': FoodPreference("Vegan", "assets/vegan.png", false),
    'Vegetarian': FoodPreference("Vegetarian", "assets/vegetarian.png", false),
  };

  // Map<String, bool?> list2 = {
  //   'Meat': false,
  //   'Dairy': false,
  //   'Eggs': false,
  //   'Gluten': false,
  // };

  savePreferences() async {
    List<String> holder_1 = [];
    // List<String> holder_2 = [];

    list1.forEach((key, value) {
      if (value.isCheck == true) {
        holder_1.add(key);
      }
    });

    // list2.forEach((key, value) {
    //   if (value == true) {
    //     holder_2.add(key);
    //   }
    // });

    // Printing all selected items on Terminal screen.
    print("printing holder_1 $holder_1");
    // Here you will get all your selected Checkbox items.
    Map<String, Object> values = <String, Object>{'counter': 1};
    SharedPreferences.setMockInitialValues(values);
    
    final SharedPreferences prefs1 = await globals.perferenceInstance;
    prefs1.setStringList('eat_preferences', holder_1);
    // Clear array after use.
    holder_1.clear();

    // final SharedPreferences prefs2 = await globals.perferenceInstance;
    // prefs2.setStringList('avoid_preferences', holder_2);
    // // Clear array after use.
    // holder_2.clear();
  }


  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => showDialogIfFirstLoaded(context));
    return Column(children: <Widget>[
      Expanded(
        child: ListView(
          children: list1.keys.map((String key) {
            return ListTile(
                onTap: null,
                leading: CircleAvatar(
                    backgroundColor: Colors.teal,
                    child: Image(image: AssetImage(list1[key]!.image))),
                title: Row(
                  children: <Widget>[
                    Expanded(child: Text(list1[key]!.name)),
                    Checkbox(
                        value: list1[key]!.isCheck,
                        onChanged: (bool? value) {
                          setState(() {
                            list1[key]!.isCheck = value!;
                          });
                          savePreferences();
                        })
                  ],
                ));
          }).toList(),
        ),
      ),

      const Text(
        "Note: The food ingredients which should be avoided will be highlighted in red.",
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      ElevatedButton(
        onPressed: () async {
          WidgetsFlutterBinding.ensureInitialized();
          // Obtain a list of the available cameras on the device.
          var cameras;
          WidgetsFlutterBinding.ensureInitialized();
          try {
             cameras = await availableCameras();
          } on CameraException catch (e) {
            print(e.description);
          }

          // final cameras = await availableCameras();
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

  showDialogIfFirstLoaded(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isFirstLoaded = prefs.getBool(keyIsFirstLoaded);
    if (isFirstLoaded == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: const Text("Disclaimer"),
            content: const Text(
                "Note that the current version of application is in Beta mode and can make some false recommendations in food choices. "
                    "Please use your discretion as well while ordering the food."),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              TextButton(
                child: const Text("Dismiss"),
                onPressed: () {
                  // Close the dialog
                  Navigator.of(context).pop();
                  prefs.setBool(keyIsFirstLoaded, false);
                },
              ),
            ],
          );
        },
      );
    }
  }

}

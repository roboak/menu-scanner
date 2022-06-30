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

  // @override
  // Widget build(BuildContext context) {
  //   return ListTile(
  //       onTap: null,
  //       leading: CircleAvatar(
  //           backgroundColor: Colors.teal,
  //           child: new Image(image: new AssetImage(foodPreference.image))),
  //       title: Row(
  //         children: <Widget>[
  //           Expanded(child: Text(foodPreference.name)),
  //           Checkbox(
  //               value: foodPreference.isCheck,
  //               onChanged: (bool? value) {
  //                 setState(() {
  //                   foodPreference.isCheck = value!;
  //                 });
  //               })
  //         ],
  //       ));
  // }

  @override
  Widget build(BuildContext context) {
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
      // Container(
      //   color: Colors.teal,
      //   //margin: EdgeInsets.all(20),
      //   padding: EdgeInsets.all(10),
      //   width: 500,
      //   height: 60,
      //   child: Row(
      //     //mainAxisAlignment: MainAxisAlignment.center,
      //     children: const [
      //       Text("  What do you not want to eat?",
      //           style: TextStyle(
      //               color: Colors.white,
      //               fontSize: 20,
      //               fontFamily: 'RobotoMono',
      //               fontWeight: FontWeight.w500)),
      //     ],
      //   ),
      // ),
      // Expanded(
      //   child: ListView(
      //     children: list2.keys.map((String key) {
      //       return CheckboxListTile(
      //         title: Text(key),
      //         value: list2[key],
      //         activeColor: Colors.teal,
      //         checkColor: Colors.white,
      //         onChanged: (bool? value) {
      //           setState(() {
      //             list2[key] = value;
      //           });
      //           savePreferences();
      //         },
      //       );
      //     }).toList(),
      //   ),
      // ),
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
}

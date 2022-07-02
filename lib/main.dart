import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart' show timeDilation;
// import 'package:shared_preferences/shared_preferences.dart';
import 'filter_check_box.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ListViews',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
          appBar: AppBar(title: Text('What do you want to eat?')),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/menu_scanner_icon.png"),
                fit: BoxFit.contain,
              ),
            ),
            child: DynamicCheckbox(),
          )
          // body: BodyLayout(), //TODO Check this our
          // body: CheckBoxListTile(), //TODO Check this our
          // body: DynamicCheckbox(), //TODO Check this our
          ),
    );
  }
}

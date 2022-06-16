import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart' show timeDilation;
// import 'package:shared_preferences/shared_preferences.dart';
import 'filter_check_box.dart';

void main() => runApp(MyApp());

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

// class BodyLayout extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return _myListView(context);
//   }
// }

// Widget _myListView(BuildContext context) {
//   return ListView(
//     children: ListTile.divideTiles(
//       context: context,
//       tiles: [
//         ListTile(
//           leading: CircleAvatar(
//             backgroundImage: AssetImage('assets/vegan.jpg'),
//           ),
//           title: Text('Vegan'),
//           onTap: () {
//             const snackBar =
//                 SnackBar(content: Text('Only vegan options will be shown'));
//             ScaffoldMessenger.of(context).showSnackBar(snackBar);

//             print(
//                 'Vegan'); // TODO save it somehow and show this in the app with a checkmark for example
//           },
//         ),
//         ListTile(
//           leading: CircleAvatar(
//             backgroundImage: AssetImage('assets/vegetarian.png'),
//           ),
//           title: Text('Vegetarian'),
//           onTap: () {
//             const snackBar = SnackBar(
//                 content: Text('Only vegetarian options will be shown'));
//             ScaffoldMessenger.of(context).showSnackBar(snackBar);

//             print(
//                 'Vegetarian'); // TODO save it somehow and show this in the app with a checkmark for example
//           },
//         ),
//         ListTile(
//           leading: CircleAvatar(
//             backgroundImage: AssetImage('assets/tomato.png'),
//           ),
//           title: Text('Tomatos'),
//           onTap: () {
//             const snackBar = SnackBar(content: Text('I don\'t like Tomatos'));
//             ScaffoldMessenger.of(context).showSnackBar(snackBar);

//             print(
//                 'Tomatos'); // TODO save it somehow and show this in the app with a checkmark for example
//           },
//         ),
//         ListTile(
//           leading: CircleAvatar(
//             backgroundImage: AssetImage('assets/onion.png'),
//           ),
//           title: Text('Onions'),
//           onTap: () {
//             const snackBar = SnackBar(content: Text('I don\'t like Onions'));
//             ScaffoldMessenger.of(context).showSnackBar(snackBar);

//             print(
//                 'Onions'); // TODO save it somehow and show this in the app with a checkmark for example
//           },
//         ),
//         ListTile(
//           leading: CircleAvatar(
//             backgroundImage: AssetImage('assets/peanut.png'),
//           ),
//           title: Text('Peanuts'),
//           onTap: () {
//             const snackBar = SnackBar(content: Text('I don\'t like Peanuts'));
//             ScaffoldMessenger.of(context).showSnackBar(snackBar);

//             print(
//                 'Peanuts'); // TODO save it somehow and show this in the app with a checkmark for example
//           },
//         ),
//         ElevatedButton(
//           onPressed: () async {
//             //try {
//             //  await Navigator.of(context).push(  // TODO Not sure how to route this properly
//             //    MaterialPageRoute(
//             //      builder: (context) => TakePictureScreenState(
//             //      imagePath: imagePath,
//             //      ),
//             //    ),
//             //  );
//             //} catch (e) {
//             // If an error occurs, log the error to the console.
//             //  print(e);
//             //}
//           },
//           child: const Text('Scan menu'),
//         ),
//       ],
//     ).toList(),
//   );
// }

// class CheckBoxListTile extends StatefulWidget {
//   const CheckBoxListTile({Key? key}) : super(key: key);

//   @override
//   State<CheckBoxListTile> createState() => _CheckBoxListTile();
// }

// class _CheckBoxListTile extends State<CheckBoxListTile> {
//   @override
//   Widget build(BuildContext context) {
//     return CheckboxListTile(
//       title: const Text('Vegan'),
//       value: timeDilation != 1.0,
//       onChanged: (bool? value) {
//         setState(() {
//           timeDilation = value! ? 1.0 : 2.0;
//         });
//       },
//       secondary: const Icon(Icons.hourglass_empty),
//     );
//   }
// }

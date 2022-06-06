import 'package:flutter/material.dart';
import 'take_picture.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ListViews',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Filter')),
        body: BodyLayout(),
      ),
    );
  }
}

class BodyLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _myListView(context);
  }
}

Widget _myListView(BuildContext context) {
  return ListView(
    children: ListTile.divideTiles(
      context: context,
      tiles: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/vegan.jpg'),
          ),
          title: Text('Vegan'),
          onTap: () {
            const snackBar = SnackBar(content: Text('Only vegan options will be shown'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            print('Vegan'); // TODO save it somehow and show this in the app with a checkmark for example
          },
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/vegetarian.png'),
          ),
          title: Text('Vegetarian'),
          onTap: () {
            const snackBar = SnackBar(content: Text('Only vegetarian options will be shown'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            print('Vegetarian'); // TODO save it somehow and show this in the app with a checkmark for example
          },
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/tomato.png'),
          ),
          title: Text('Tomatos'),
          onTap: () {
            const snackBar = SnackBar(content: Text('I don\'t like Tomatos'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            print('Tomatos'); // TODO save it somehow and show this in the app with a checkmark for example
          },
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/onion.png'),
          ),
          title: Text('Onions'),
          onTap: () {
            const snackBar = SnackBar(content: Text('I don\'t like Onions'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            print('Onions'); // TODO save it somehow and show this in the app with a checkmark for example
          },
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/peanut.png'),
          ),
          title: Text('Peanuts'),
          onTap: () {
            const snackBar = SnackBar(content: Text('I don\'t like Peanuts'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            print('Peanuts'); // TODO save it somehow and show this in the app with a checkmark for example
          },
        ),
        ElevatedButton(
          onPressed: () async {
            //try {
            //  await Navigator.of(context).push(  // TODO Not sure how to route this properly
            //    MaterialPageRoute(
            //      builder: (context) => TakePictureScreenState(
            //      imagePath: imagePath,
            //      ),
            //    ),
            //  );
            //} catch (e) {
            // If an error occurs, log the error to the console.
            //  print(e);
            //}
          },
          child: const Text('Scan menu'),
          ),
      ],
    ).toList(),
  );
}
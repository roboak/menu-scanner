library menu_scanner.globals;

import 'package:shared_preferences/shared_preferences.dart';

List<String> non_veg_en = [
  "beef",
  "meat",
  "fish",
  "steak",
  "ham",
  "pork",
  "wings",
  "chicken",
  "shrimp",
  "bbq",
  "ribs",
  "salmon",
  "seafood"
];
List<String> non_veg_de = [
  "rindfleisch",
  "fleisch",
  "fisch",
  "steak",
  "schinken",
  "schweinefleisch",
  "flügel",
  "huhn",
  "garnelen",
  "bbq",
  "rippen",
  "kebab",
  "kebap",
  "fischrogen"
];

// ignore: non_constant_identifier_names
List<String> non_veg_en_de = List.from(non_veg_de)..addAll(non_veg_en);

final Future<SharedPreferences> perferenceInstance =
    SharedPreferences.getInstance();

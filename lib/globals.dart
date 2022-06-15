library menu_scanner.globals;

import 'package:shared_preferences/shared_preferences.dart';

List<String> non_veg_en = [
  "beef",
  "meat",
  "fish",
  "steak",
  "ham",
  "duck",
  "pork",
  "wings",
  "chicken",
  "shrimp",
  "bbq",
  "ribs",
  "salmon",
  "seafood",
  "egg",
  "salami"
];
List<String> non_veg_de = [
  "hähnchen",
  "rindfleisch",
  "fleisch",
  "fisch",
  "steak",
  "schinken",
  "schweine",
  "flügel",
  "huhn",
  "hühn"
      "garnelen",
  "bbq",
  "rippen",
  "kebab",
  "kebap",
  "fischrogen",
  "ente",
  "schnitzel",
  "wurst",
  "weiner",
  "flugel",
  "puten"
];

// ignore: non_constant_identifier_names
List<String> non_veg_en_de = List.from(non_veg_de)..addAll(non_veg_en);

final Future<SharedPreferences> perferenceInstance =
    SharedPreferences.getInstance();

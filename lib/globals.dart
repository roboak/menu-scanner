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
  "salami",
  "tuna",
  "salmon"
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
  "hühn",
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
  "puten",
];

List<String> non_vegan_en = [
  "cheese",
  "butter",
  "milk",
  "cream",
  "mayonnaise",
  "honey",
  "yoghurt",
  "curd",
  "gelato",
  "custard",
  "casein"
];

List<String> non_vegan_de = [
  "käse",
  "butter",
  "milch",
  "creme",
  "sahne",
  "mayonnaise",
  "honig",
  "joghurt",
  "quark",
  "eis",
  "pudding",
  "kasein"
];
// ignore: non_constant_identifier_names
List<String> non_veg_en_de = List.from(non_veg_de)..addAll(non_veg_en);
List<String> non_vegan_en_de = List.from(non_vegan_de)..addAll(non_vegan_en);

final Future<SharedPreferences> perferenceInstance =
    SharedPreferences.getInstance();

String developer_email = "akashshubham95@gmail.com";

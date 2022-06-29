library menu_scanner.globals;

import 'package:shared_preferences/shared_preferences.dart';

Set<String> non_vegan_1root_de = {};
Set<String> non_vegan_keyroots_de = {};
Set<String> non_veg_1root_de = {};
Set<String> non_veg_keyroots_de = {};
Set<String> non_veg_en = {};
Set<String> non_vegan_en = {};

final Future<SharedPreferences> perferenceInstance =
    SharedPreferences.getInstance();

String developer_email = "akashshubham95@gmail.com";

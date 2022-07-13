library menu_scanner.globals;

import 'package:shared_preferences/shared_preferences.dart';

Map veg_filters = {};
Map vegan_veg_filters = {};
Set vegan_whitelist_keyroots = {};
Set veg_whitelist_keyroots = {};

final Future<SharedPreferences> perferenceInstance =
    SharedPreferences.getInstance();

String developer_email = "akashshubham95@gmail.com";

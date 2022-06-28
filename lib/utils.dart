import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:string_similarity/string_similarity.dart';
import 'globals.dart' as globals;

class Utils {
  bool textMatch(String key, List<String> filter) {
    //         gloabls.non_veg_en_de.contains(element.text
    bool result = false;
    key = key.toLowerCase().replaceAll(RegExp('[^A-Za-zäöüÄÖÜ]'), '');
    // print("key = $key");
    for (String ele in filter) {
      // print("element: $ele");
      double matchPercentage = ele.similarityTo(key);
      // print(
      //     "match percentage of dict_ele = $ele with ocr_word = $key: $matchPercentage");

      if (key.contains(ele) && matchPercentage > 0.4) {
        // Case: when the detected word spelling is correct.
        result = true;
        // print("found the result as a substring");

        break;
      } else {
        // Do approximate string matching to account for some spelling errors.

        if (matchPercentage > 0.8) {
          result = true;
        } else {
          result = false;
        }
      }
    }
    // print("result = $result");
    return result;
  }

  Future<List<String>> loadAsset(String file_name) async {
    String text = await rootBundle.loadString('assets/' + file_name);
    LineSplitter ls = const LineSplitter();
    return ls.convert(text);
  }

  loadDict() async {
    globals.non_vegan_en = await loadAsset("nonvegan_food_en.txt");
    globals.non_veg_en = await loadAsset("nonvegetarian_food_en.txt");

    globals.non_vegan_de = await loadAsset("nonvegan_exclusive_food_de.txt");
    globals.non_veg_de = await loadAsset("nonvegetarian_food_de.txt");
    globals.non_veg_en_de = List.from(globals.non_veg_de)
      ..addAll(globals.non_veg_en);
    globals.non_vegan_en_de = List.from(globals.non_vegan_de)
      ..addAll(globals.non_vegan_en);

    // print("______ Debug______");
    // print(nonvegan_food_list_en);
    // print(nonvegan_food_list_en[0]);
  }
}

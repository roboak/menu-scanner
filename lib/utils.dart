import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:string_similarity/string_similarity.dart';
import 'globals.dart' as globals;

enum MatchStatus { MATCHED, UNMATCHED, NOT_SURE }

class Utils {
  MatchStatus textMatch(String detected_word, List<String> filter) {
    MatchStatus result = MatchStatus.UNMATCHED;
    detected_word =
        detected_word.toLowerCase().replaceAll(RegExp('[^A-Za-zäöüÄÖÜ]'), '');
    // print("detected_word = $detected_word");
    for (String dict_word in filter) {
      // print("dict_word: $dict_word");

      // double matchPercentage = dict_word.similarityTo(detected_word);

      // print(
      //     "match percentage of dict_ele = $ele with ocr_word = $key: $matchPercentage");

      // Case: when the detected word spelling is correct.
      // print("found the result as a substring");
      // If ele in the 1st half or last half of ele, then only consider the match.
      // Avoid matches (ham, champignon); (ei, reis); (egg, veggie)
      // Exception: (Ei, Eis)
      if ((detected_word.length >= dict_word.length) &&
          ((detected_word.substring(0, dict_word.length) == dict_word) ||
              (detected_word.substring(detected_word.length - dict_word.length,
                      detected_word.length) ==
                  dict_word))) {
        // print(
        //     "Detected word1: " + detected_word.substring(0, dict_word.length));
        if (detected_word.length - dict_word.length == 1) {
          result = MatchStatus.NOT_SURE;
        } else {
          result = MatchStatus.MATCHED;
          break;
        }
      }
      //else if (matchPercentage > 0.8) {
      //   // Do approximate string matching to account for some spelling errors.
      //   result = MatchStatus.MATCHED;
      //   break;
      // }
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

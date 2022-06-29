import 'dart:convert';
import 'package:flutter/services.dart';
import 'globals.dart' as globals;

enum MatchStatus { MATCHED, UNMATCHED, NOT_SURE }

class Utils {
  MatchStatus textMatch(String detected_word, Set<String> oneroot_filter,
      Set<String> keyroot_filter) {
    detected_word = detected_word
        .toLowerCase()
        .replaceAll(RegExp('[^a-zäöü]'), '')
        .replaceAll('ä', 'a')
        .replaceAll('ö', 'o')
        .replaceAll('ü', 'u');

    for (String dict_word in keyroot_filter) {
      if (detected_word.contains(dict_word)) return MatchStatus.MATCHED;
    }
    for (String dict_word in oneroot_filter) {
      if (dict_word.length > 4) {
        if (detected_word.contains(dict_word)) return MatchStatus.MATCHED;
      } else {
        if (detected_word == dict_word) return MatchStatus.MATCHED;
      }
    }
    return MatchStatus.UNMATCHED;
  }

  Future<Set<String>> loadAsset(String file_name) async {
    String text = await rootBundle.loadString('assets/' + file_name);
    LineSplitter ls = const LineSplitter();
    return ls.convert(text).toSet();
  }

  // When done with debugging, preprocess the vocabs once and don't call this at
  // runtime
  Set<String> preprocessVocab(Set vocab) {
    Set<String> preprocessed = new Set<String>();
    vocab.forEach((v) => preprocessed
        .add(v.replaceAll('ä', 'a').replaceAll('ö', 'o').replaceAll('ü', 'u')));

    return preprocessed;
  }

  loadDict() async {
    globals.non_vegan_1root_de =
        preprocessVocab(await loadAsset("nonvegan_veg_food_de.txt"));
    globals.non_vegan_keyroots_de = preprocessVocab(
        await loadAsset("nonvegan_veg_food_keyroots_de.txt"));
    globals.non_veg_1root_de =
        preprocessVocab(await loadAsset("nonvegetarian_food_de.txt"));
    globals.non_veg_keyroots_de =
        preprocessVocab(await loadAsset("nonvegetarian_food_keyroots_de.txt"));

    // Preprocess the vocabs by replacing the umlauts
  }
}

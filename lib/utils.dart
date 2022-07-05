import 'dart:convert';
import 'package:flutter/services.dart';
import 'globals.dart' as globals;

enum MatchStatus { MATCHED, UNMATCHED, NOT_SURE }

class Utils {
  MatchStatus textMatch(String detected_word, List<String> langs, Map filters) {
    detected_word = detected_word
        .toLowerCase()
        .replaceAll(RegExp('[^a-zäöü]'), '')
        .replaceAll(RegExp('[üûūùú]'), 'u')
        .replaceAll(RegExp('[ēëėèéê]'), 'e')
        .replaceAll(RegExp('[äãåāâàá]'), 'a')
        .replaceAll(RegExp('[šś]'), 's')
        .replaceAll(RegExp('[ç]'), 'c')
        .replaceAll(RegExp('[öôòóõō]'), 'o')
        .replaceAll(RegExp('[íîīìï]'), 'i');

    for (String ln in langs) {
      print(ln);
      if (filters.containsKey(ln)) {
        Map ln_filters = filters[ln];
        if (ln_filters.containsKey('keyroot')) {
          Set<String> keyroot_filter = ln_filters['keyroot'];
          for (String dict_word in keyroot_filter) {
            if (detected_word.contains(dict_word)) return MatchStatus.MATCHED;
          }
        }

        if (ln_filters.containsKey('1root')) {
          Set<String> oneroot_filter = ln_filters['1root'];

          for (String dict_word in oneroot_filter) {
            if (dict_word.length > 4) {
              if (detected_word.contains(dict_word)) return MatchStatus.MATCHED;
            } else {
              if (detected_word == dict_word) return MatchStatus.MATCHED;
            }
          }
        }
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
    Set<String> non_vegan_1root_de =
        preprocessVocab(await loadAsset("nonvegan_veg_food_de.txt"));
    Set<String> non_vegan_keyroots_de =
        preprocessVocab(await loadAsset("nonvegan_veg_food_keyroots_de.txt"));
    Set<String> non_veg_1root_de =
        preprocessVocab(await loadAsset("nonvegetarian_food_de.txt"));
    Set<String> non_veg_keyroots_de =
        preprocessVocab(await loadAsset("nonvegetarian_food_keyroots_de.txt"));

    Set<String> non_vegan_en = await loadAsset("nonvegan_veg_food_en.txt");
    Set<String> non_veg_en = await loadAsset("nonvegetarian_food_en.txt");

    globals.vegan_veg_filters = {
      "de": {"1root": non_vegan_1root_de, "keyroot": non_vegan_keyroots_de},
      "en": {"1root": non_vegan_en}
    };

    globals.veg_filters = {
      "de": {"1root": non_veg_1root_de, "keyroot": non_veg_keyroots_de},
      "en": {"1root": non_veg_en}
    };
  }

  isVegan(String detected_word, List<String> lang) {
    if (textMatch(detected_word, lang, globals.vegan_veg_filters) ==
            MatchStatus.MATCHED ||
        isVegetarian(detected_word, lang)) {
      return true;
    } else {
      return false;
    }
  }

  isVegetarian(String detected_word, List<String> lang) {
    if (textMatch(detected_word, lang, globals.veg_filters) ==
        MatchStatus.MATCHED) {
      return true;
    } else {
      return false;
    }
  }
}

import 'dart:convert';
import 'package:flutter/services.dart';
import 'globals.dart' as globals;

enum MatchStatus { MATCHED, UNMATCHED, NOT_SURE }

class Utils {
  String postprocessText(String wordbox) {
    return wordbox
        .toLowerCase()
        .replaceAll(RegExp('[^a-zäöü]'), '')
        .replaceAll(RegExp('[üûūùú]'), 'u')
        .replaceAll(RegExp('[ēëėèéê]'), 'e')
        .replaceAll(RegExp('[äãåāâàá]'), 'a')
        .replaceAll(RegExp('[šś]'), 's')
        .replaceAll(RegExp('[ç]'), 'c')
        .replaceAll(RegExp('[öôòóõō]'), 'o')
        .replaceAll(RegExp('[íîīìï]'), 'i');
  }

  // When done with testing, preprocess the vocabs once and don't call this at
  // runtime for battery saving
  Set<String> preprocessVocab(Set vocab) {
    Set<String> preprocessed = new Set<String>();
    vocab.forEach((v) => preprocessed.add(postprocessText(v)));

    return preprocessed;
  }

  MatchStatus textMatch(String detected_word, List<String> langs, Map filters) {
    detected_word = postprocessText(detected_word);

    // If we have no filters for one of the detected languages, use all the filters we have
    // because, e.g., after a french word 'crème' is preprocessed, it can become english
    if (!(filters.keys.toSet().containsAll(langs.toSet()))) {
      langs = filters.keys.toList().cast<String>();
    }

    for (String ln in langs) {
      // Keyroot search goes first
      if (filters[ln].containsKey('keyroot')) {
        for (String dict_word in filters[ln]['keyroot']) {
          if (detected_word.contains(dict_word)) return MatchStatus.MATCHED;
        }
      }
      // If keyroots were not detected, search of other filter words are contained in the parsed string
      if (filters[ln].containsKey('1root')) {
        for (String dict_word in filters[ln]['1root']) {
          // If a dictionary word's length is > 4, search for substring matching
          if (dict_word.length > 4) {
            if (detected_word.contains(dict_word)) return MatchStatus.MATCHED;
          } else {
            // For the short words (ei, egg), search for the exact match
            if (detected_word == dict_word) return MatchStatus.MATCHED;
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

  loadDict() async {
    Set<String> non_vegan_1root_de =
        preprocessVocab(await loadAsset("nonvegan_veg_food_de.txt"));
    Set<String> non_vegan_keyroots_de =
        preprocessVocab(await loadAsset("nonvegan_veg_food_keyroots_de.txt"));
    Set<String> non_veg_1root_de =
        preprocessVocab(await loadAsset("nonvegetarian_food_de.txt"));
    Set<String> non_veg_keyroots_de =
        preprocessVocab(await loadAsset("nonvegetarian_food_keyroots_de.txt"));

    Set<String> non_vegan_1root_en =
        await loadAsset("nonvegan_veg_food_en.txt");
    Set<String> non_veg_1root_en = await loadAsset("nonvegetarian_food_en.txt");
    Set<String> non_vegan_keyroots_en =
        await loadAsset("nonvegan_veg_food_keyroots_en.txt");
    Set<String> non_veg_keyroots_en =
        await loadAsset("nonvegetarian_food_keyroots_en.txt");

    globals.vegan_veg_filters = {
      "de": {"1root": non_vegan_1root_de, "keyroot": non_vegan_keyroots_de},
      "en": {"1root": non_vegan_1root_en, "keyroot": non_vegan_keyroots_en}
    };

    globals.veg_filters = {
      "de": {"1root": non_veg_1root_de, "keyroot": non_veg_keyroots_de},
      "en": {"1root": non_veg_1root_en, "keyroot": non_veg_keyroots_en}
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

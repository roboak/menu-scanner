import 'package:string_similarity/string_similarity.dart';

class Utils {
  bool textMatch(String key, List<String> filter) {
    //         gloabls.non_veg_en_de.contains(element.text
    bool result = false;
    key = key.toLowerCase().replaceAll(RegExp('[^A-Za-zäöüÄÖÜ]'), '');
    // print("key = $key");
    for (String ele in filter) {
      // print("element: $ele");
      double matchPercentage = ele.similarityTo(key);
      print(
          "match percentage of dict_ele = $ele with ocr_word = $key: $matchPercentage");

      if (key.contains(ele) && matchPercentage > 0.4) {
        // Case: when the detected word spelling is correct.
        result = true;
        print("found the result as a substring");

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
    print("result = $result");
    return result;
  }
}

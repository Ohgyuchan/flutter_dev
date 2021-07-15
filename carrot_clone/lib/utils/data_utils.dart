import 'package:intl/intl.dart';

class DataUtils {
  static final formatTowon = new NumberFormat("#,###", "ko_KR");
  static String calcStringToWon(String priceString) {
    if (priceString == '무료나눔') return priceString;
    return "${formatTowon.format(int.parse(priceString))}원";
  }
}

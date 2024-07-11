import 'dart:math';
import 'package:sjyblairgarden/statics/variables/strings.dart';

class TulipQuotesController {
  static List<String> quotes = Strings.tulipQuotes;

  static String getTulipQuote() {
    final random = Random();
    final index = random.nextInt(quotes.length);
    return quotes[index];
  }
}

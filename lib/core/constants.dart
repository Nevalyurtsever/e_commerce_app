import 'package:intl/intl.dart';

class Constants {
  static dateTimeFormat(String localeName, DateTime date) {
    return DateFormat('yyyy-MM-dd HH:mm', localeName).format(date);
  }

  static currencyFormat(String locale, double amount) {
    return NumberFormat.simpleCurrency(locale: locale, name: "€")
        .format(amount);
  }

  static dateFormat(String localeName, DateTime date) {
    return DateFormat('yyyy.MM.dd', localeName).format(date);
  }
}

import 'package:intl/intl.dart';

class CWDateUtils {
  static String localDateFormatter(DateTime dt) {
    var dateValue = DateFormat("yyyy-MM-ddTHH:mm:ssZ")
        .parseUTC(dt.toIso8601String())
        .toLocal();
    String formattedDate = DateFormat("dd/MM/yyyy HH:mm").format(dateValue);
    return formattedDate;
  }
}

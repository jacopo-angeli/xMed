import 'package:intl/intl.dart';

class CWDateUtils {
  // TODO REFACTOR
  static String localDateFormatter(DateTime dt) {
    var dateValue = DateFormat("yyyy-MM-ddTHH:mm:ssZ")
        .parseUTC(dt.toIso8601String())
        .toLocal();
    String formattedDate = DateFormat("dd/MM/yyyy HH:mm").format(dateValue);
    return formattedDate;
  }

  static String localDateToDateTimeCompatibleString(String dt) {
    var dateValue = DateFormat("dd/MM/yyyy HH:mm").parse(dt);
    String formattedDate = DateFormat("yyyy-MM-dd HH:mm:ss").format(dateValue);
    return formattedDate;
  }
}

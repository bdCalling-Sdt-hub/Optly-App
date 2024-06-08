import 'package:intl/intl.dart';
import 'package:optly/utils/app_strings.dart';

class DateTimeFormatterHelper {

  static String calculateTimeDifference(DateTime? dateTime) {
    DateTime currentDateTime = DateTime.now();
    Duration difference = currentDateTime.difference(dateTime==null?DateTime.now().add(Duration(minutes: 1)):dateTime.add(Duration(minutes: 1)));
    int totalMinutes = difference.inMinutes;
    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes % 60;

    var _difference = '$hours Std. $minutes Min.';
    return _difference;
  }
}
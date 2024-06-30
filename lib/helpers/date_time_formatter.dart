import 'package:intl/intl.dart';
import 'package:optly/utils/app_strings.dart';

class DateTimeFormatterHelper {

  static String formatMM(DateTime  date){
    String formattedMonth = DateFormat('MM').format(date);
    return formattedMonth;
  }

  static String formatDD(DateTime  date){
    String formattedMonth = DateFormat("EEE",'de').format(date);
    return formattedMonth;
  }

  static String formatDDMM(DateTime  date){
    String formattedMonth = DateFormat('dd.MM','de').format(date);
    return formattedMonth;
  }

  static String calculateTimeDifference(DateTime? dateTime) {
    DateTime currentDateTime = DateTime.now();
    Duration difference = currentDateTime.difference(dateTime==null?DateTime.now().add(Duration(minutes: 1)):dateTime.add(Duration(minutes: 1)));
    int totalMinutes = difference.inMinutes;
    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes % 60;

    var _difference = '$hours Std. $minutes Min.';
    return _difference;
  }

  static String calculateMinutesToHours(int totalMinutes) {


    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes % 60;

    var _difference =hours==0? '$minutes Min.':'$hours Std. $minutes Min.';
    return _difference;
  }

  static String calculateMinutesToHour(int totalMinutes) {
    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes % 60;

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr h';
  }

}
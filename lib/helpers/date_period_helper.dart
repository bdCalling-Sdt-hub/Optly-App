import 'package:intl/intl.dart';

class DatePeriod {
  final DateTime startDate;
  final DateTime endDate;

  DatePeriod(this.startDate) : endDate = startDate.add(Duration(days: 6));

  DatePeriod next() {
    return DatePeriod(startDate.add(Duration(days: 7)));
  }

  DatePeriod previous() {
    return DatePeriod(startDate.subtract(Duration(days: 7)));
  }

  String getFormattedStartDate() {
    return DateFormat('yyyy-MM-dd').format(startDate);
  }
  List<Map<String, String>> getDayNameAndDates() {
    List<Map<String, String>> days = [];
    for (int i = 0; i < 7; i++) {
      DateTime currentDate = startDate.add(Duration(days: i));
      days.add({
        'day': DateFormat('EEEE').format(currentDate),
        'date': DateFormat('dd.MM.yyyy').format(currentDate),
      });
    }
    return days;
  }


  @override
  String toString() {
    return '${_formatDate(startDate)} - ${_formatDate(endDate)} ${startDate.year}';
  }

  String _formatDate(DateTime date) {
    return '${date.day}.${DateFormat('MMMM').format(date)}';
  }
}

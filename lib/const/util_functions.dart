import 'dart:math';

String generateRandomId() {
  final Random random = Random();
  const int idLength = 14;
  const String allowedChars = 'abcdefghijklmnopqrstuvwxyz0123456789';

  String randomId = '';

  for (int i = 0; i < idLength; i++) {
    final int randomIndex = random.nextInt(allowedChars.length);
    randomId += allowedChars[randomIndex];
  }

  return randomId;
}

String formatTimestampToAmPm(int timestamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  String period = dateTime.hour >= 12 ? 'pm' : 'am';
  int hourIn12HourFormat =
      dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
  String formattedTime =
      '${hourIn12HourFormat.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} $period';
  return formattedTime;
}

String getTimeInAMPMFormat(DateTime dateTime) {
  String ampm = dateTime.hour >= 12 ? 'PM' : 'AM';
  int hour = dateTime.hour % 12;
  hour = hour == 0 ? 12 : hour; // Convert 0 to 12 for 12-hour clock
  String minute = dateTime.minute.toString().padLeft(2, '0');
  return '$hour:$minute $ampm';
}

String getDateInDayMonthYearFormat(DateTime dateTime) {
  String day = dateTime.day.toString();
  String month = dateTime.month.toString();
  String year = dateTime.year.toString();
  return '$day-$month-$year';
}

Duration calculateRemainingTime(String endDateParam, String endTimeParam) {
  String endDate = endDateParam;
  String endTime = "$endTimeParam:00";

  List<String> endDateParts = endDate.split("-");
  List<String> endTimeParts = endTime.split(":");

  int year = int.parse(endDateParts[0]);
  int month = int.parse(endDateParts[1]);
  int day = int.parse(endDateParts[2]);

  int hour = int.parse(endTimeParts[0]);
  int minute = int.parse(endTimeParts[1]);
  int second = int.parse(endTimeParts[2]);

  DateTime endParsedTime = DateTime(year, month, day, hour, minute, second);
  final now = DateTime.now();
  return endParsedTime.difference(now);
}

import 'dart:math';

class UtilFunctions {
  int? dateTimeToTimestamp(String dateString, String timeString) {
    try {
      // Parse the date string
      final dateParts = dateString.split('-');
      if (dateParts.length != 3) {
        throw Exception('Invalid date format');
      }
      final year = int.parse(dateParts[0]);
      final month = int.parse(dateParts[1]);
      final day = int.parse(dateParts[2]);

      // Parse the time string
      final timeParts = timeString.split(':');
      if (timeParts.length != 2) {
        throw Exception('Invalid time format');
      }
      final hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);

      // Create a DateTime object
      final dateTime = DateTime(year, month, day, hour, minute);

      // Convert DateTime to timestamp in milliseconds
      final timestamp = dateTime.millisecondsSinceEpoch;
      return timestamp;
    } catch (e) {
      print('Error parsing date or time: $e');
      return null; // You can handle the error as needed
    }
  }

  String generateRandomId() {
    final random = Random();
    const characters =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final id = List.generate(
        12, (index) => characters[random.nextInt(characters.length)]).join();
    return id;
  }

  int getFutureTimeMillis(int duration) {
    final currentTime = DateTime.now();
    final futureTime = currentTime.add(Duration(hours: duration));
    final futureTimestamp = futureTime.millisecondsSinceEpoch;
    return futureTimestamp;
  }

  String getTimeLeftOrTimePassed(String dateString, String timeString) {
    try {
      // Parse the date string
      final dateParts = dateString.split('-');
      if (dateParts.length != 3) {
        throw Exception('Invalid date format');
      }
      final year = int.parse(dateParts[0]);
      final month = int.parse(dateParts[1]);
      final day = int.parse(dateParts[2]);

      // Parse the time string
      final timeParts = timeString.split(':');
      if (timeParts.length != 2) {
        throw Exception('Invalid time format');
      }
      final hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);

      // Create a DateTime object for the target date and time
      final targetDateTime = DateTime(year, month, day, hour, minute);

      // Calculate the time difference
      final now = DateTime.now();
      final timeDifference = targetDateTime.difference(now);

      // Calculate days and hours
      final days = timeDifference.inDays;
      final hours = timeDifference.inHours % 24;

      // Check if the time has already passed
      if (now.isAfter(targetDateTime)) {
        return 'Time\'s up!';
      }

      // Construct the time left string
      String timeLeft = '';
      if (days > 0) {
        timeLeft += '$days day${days > 1 ? 's' : ''} ';
      }
      if (hours > 0) {
        timeLeft += '$hours hour${hours > 1 ? 's' : ''}';
      }

      return timeLeft.trim();
    } catch (e) {
      print('Error parsing date or time: $e');
      return 'Invalid date or time format.';
    }
  }

  String formatTimestamp(int timestampMillis) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestampMillis);
    final formattedDate =
        '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
    final formattedTime =
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    return '$formattedDate $formattedTime';
  }
}

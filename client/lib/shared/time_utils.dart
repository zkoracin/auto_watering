import 'package:client/shared/constants/day_names.dart';

class TimeUtils {
  static String formatTwoDigits(int? value) {
    return value?.toString().padLeft(2, '0') ?? '00';
  }

  static String formatClockTime(int? hour, int? minute) {
    if (hour == null || minute == null) return '--:--';
    return '${formatTwoDigits(hour)}:${formatTwoDigits(minute)}';
  }

  static String formatDayAndTime(int? day, int? hour, int? minute) {
    final dayName = dayNames[day ?? 1];
    final time = formatClockTime(hour, minute);
    return '$dayName $time'.trim();
  }
}

import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

extension DateTimeExt on DateTime {
  String format(String format) {
    return DateFormat(format).format(this);
  }

  DateTime get normalizeDate => DateTime(year, month, day);

  int get age {
    final birthday = Jiffy(format('dd/MM/yyyy'), 'dd/MM/yyyy');
    final now = Jiffy(DateTime.now().normalizeDate.format('dd/MM/yyyy'), 'dd/MM/yyyy');
    return birthday.diff(now, Units.YEAR).toInt().abs();
  }

  String get dayAgo {
    final now = DateTime.now().normalizeDate;
    if (now.difference(this).inDays == 0) {
      return 'Hôm nay';
    }
    if (now.difference(this).inDays.abs() == 1) {
      return 'Hôm qua';
    }
    return format('dd/MM/yyyy');
  }

  String get minAgo {
    final now = DateTime.now();
    final diffMins = now.difference(this).inMinutes.abs();
    final diffHours = now.difference(this).inHours.abs();
    if (diffHours > 8) {
      return format('HH:mm');
    }
    if (diffHours > 0) {
      return '$diffHours giờ trước';
    }
    if (diffMins == 0) {
      return 'Vừa xong';
    }
    return '$diffMins phút trước';
  }

  String get greetingKey {
    if (hour <= 12) {
      return 'home.greeting.morning';
    }
    if (hour > 12 && hour <= 18) {
      return 'home.greeting.afternoon';
    }
    return 'home.greeting.evening';
  }
}

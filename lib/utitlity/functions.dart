import 'package:intl/intl.dart';

String getHumanReadableDate(int dt) {
  DateFormat dateFormat = DateFormat('dd/MM/yy hh:mm a');
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(dt);

  String humanDate = dateFormat.format(dateTime);

  return humanDate;
}
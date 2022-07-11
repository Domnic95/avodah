String timeDifference(DateTime date) {
  DateTime now = DateTime.now();
  String time = '';
 
  String? timeconvention = date.hour >= 12 ? "pm" : "am";
  String? hour =
      date.hour > 13 ? (24 - date.hour).toString() : date.hour.toString();
  if (now.difference(date).inDays > 1) {
    time = "${date.day}/${date.month}/${date.year}";
  } else {
    time = "${hour}:${date.minute} ${timeconvention}";
  }
  return time;
}

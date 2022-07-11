String dateTime_format(DateTime time) {
  return "${time.day}/${time.month}/${time.year}";
}

DateTime convertStringIntoDate(String dateString) {
  int year = int.parse(dateString.substring(6));
  int day = int.parse(dateString.substring(3, 5));
  int month = int.parse(dateString.substring(0, 2));

  // print(DateTime(
  //     int.parse(dateString.substring(6)),
  //     int.parse(dateString.substring(3, 5)),
  //     int.parse(dateString.substring(0, 2))));

  return DateTime(year, month, day, 00, 00, 00, 000);
}

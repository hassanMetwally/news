import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;


String parseHumanDateTime(String dateTime) {
  Duration timeAgo = DateTime.now().difference(DateTime.parse(dateTime));
  DateTime theDifference = DateTime.now().subtract(timeAgo);
  return timeago.format(theDifference);
}

Widget loading() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}

Widget connectionError() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Center(
      child: Text("Connection Error!!!!"),
    ),
  );
}

Widget error(var error) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Center(
      child: Text(error.toString()),
    ),
  );
}

Widget noData() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Center(
      child: Text("No Data Available"),
    ),
  );
}

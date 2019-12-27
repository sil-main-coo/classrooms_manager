import 'package:intl/intl.dart';

import 'lesson.dart';

class Schedule {
  int dateInt;
  DateTime date;
  List<Lesson> lessons;
  DateFormat _inputFormat = DateFormat("dd/MM/yyyy");

  Schedule({this.date, this.lessons});

  Schedule.fromJson(Map<String, dynamic> json) {
    date= _inputFormat.parse(json['date_to_string']);
    dateInt= json['date'];
    if (json['lessons_list'] != null) {
      lessons = new List<Lesson>();
      json['lessons_list'].forEach((v) {
        lessons.add(new Lesson.fromJson(v));
      });

      lessons.sort(
              (Lesson objA, Lesson objB) => objA.lesson.compareTo(objB.lesson));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.lessons != null) {
      data['lessons'] = this.lessons.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

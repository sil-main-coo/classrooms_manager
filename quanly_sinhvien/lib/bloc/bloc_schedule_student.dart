
import 'dart:async';
import 'package:quanly_sinhvien/api/server/api_schedule.dart';
import 'package:quanly_sinhvien/model/response/schedule/lesson.dart';
import 'package:quanly_sinhvien/model/response/schedule/schedule.dart';
import 'package:quanly_sinhvien/reponsitory_api/server/repo_schedule.dart';
import 'package:quanly_sinhvien/singleton/singletont_token.dart';

class ScheduleStudentBloc{
  final ScheduleApiRepo _scheduleApi= ScheduleApi();
  final SingletonToken _singletonToken= SingletonToken.getInstance();

  StreamController<Map<DateTime, List>> _streamMapSchedules = StreamController();
  Stream get streamMapSchedules => _streamMapSchedules.stream;

  Map<DateTime, List> _schedules = new Map();
  List<Lesson> _allScheduleByLessonList = new List<Lesson>();
  List<Schedule> _allScheduleByWeekList = new List();
  List _selectDay = new List();

  dispose(){
    _streamMapSchedules.close();
  }

  DateTime timerConvert(DateTime time) {
    int year = time.year;
    int month = time.month;
    int day = time.day;
    DateTime currentDay = DateTime(year, month, day);
    return currentDay;
  }

//  List<Schedule> get allSchudeleByWeekList => _allSchudeleByWeekList;
//
//  List get selectDay => _selectDay;
//
//  set selectDay(List value) {
//    _selectDay = value;
//    notifyListeners();
//  }
//
//
//  Map<DateTime, List> get schedules => _schedules;
//
//  set schudeles(Map<DateTime, List> value) {
//    _schudeles = value;
//    notifyListeners();
//  }
//
//  set allSchudeleByWeekList(List<Schedule> value) {
//    _allSchudeleByWeekList = value;
//  }
//
//  List<Lesson> get allSchudeleByLessonList => _allSchudeleByLessonList;
//
//  set allSchudeleByLessonList(List<Lesson> value) {
//    _allSchudeleByLessonList = value;
//    notifyListeners();
//  }


  getScheduleData() async {
    final response= await _scheduleApi.getScheduleStudent(_singletonToken.loginSession.token);
    if(response.success){
      final List<Schedule> allScheduleList = response.schedules;
      List eventLessons;

      allScheduleList.sort(
              (Schedule objA, Schedule objB) => objA.date.compareTo(objB.date));

      allScheduleList.forEach((obj) {
        eventLessons= new List();
        obj.lessons.forEach((lessonInfo) {
          eventLessons.add(lessonInfo.toString());
       });

        _schedules[obj.date] = eventLessons;
      });
      _streamMapSchedules.sink.add(_schedules);
    }else{
      _streamMapSchedules.sink.addError(response.message);
    }

  }

}

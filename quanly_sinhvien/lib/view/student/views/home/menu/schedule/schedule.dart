import 'package:flutter/material.dart';
import 'package:quanly_sinhvien/bloc/bloc_schedule_student.dart';
import 'package:quanly_sinhvien/utils/values/colors.dart';
import 'package:quanly_sinhvien/view/widgets/loader/custom/loader_three_bounce.dart';
import 'package:table_calendar/table_calendar.dart';

class SchedulePage extends StatefulWidget {
  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<SchedulePage>  with TickerProviderStateMixin{
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;
  DateTime _selectedDay;

  final ScheduleStudentBloc _studentBloc= ScheduleStudentBloc();

  @override
  void initState() {
    super.initState();
    _studentBloc.getScheduleData();
    _selectedDay = _studentBloc.timerConvert(DateTime.now()); // get current time
    print('>> selected: '+_selectedDay.toString());

    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    _studentBloc.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected ${day.toString()}');
    setState(() {
      _selectedDay = _studentBloc.timerConvert(day);
    });
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Schedule"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.access_time),onPressed: (){
            // todo select date
          },)
        ],
      ),
      body: StreamBuilder<Map<DateTime, List>>(
        stream: _studentBloc.streamMapSchedules,
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting: return LoaderThreeBounce();
            case ConnectionState.active:
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  _buildTableCalendar(snapshot.data),
                  const SizedBox(height: 8.0),
                  Expanded(child: _buildEventList(snapshot.data)),
                ],
              );
            case ConnectionState.done:
          }
          return null; // unreachable
        }
      ),
    );
  }

  // Simple TableCalendar configuration (using Styles)
  Widget _buildTableCalendar(Map<DateTime, List> schedule) {
    debugPrint('${schedule.toString()}');
    return TableCalendar(
      calendarController: _calendarController,
      events: schedule,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.redAccent[400],
        todayColor: Colors.redAccent[100],
        markersColor: secondaryDark,
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        centerHeaderTitle: true,
        formatButtonTextStyle: TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: primaryLight,
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
    );
  }

//  Widget _buildButtons() {
//        const SizedBox(height: 8.0),
//        RaisedButton(
//          child: Text('Set day ${dateTime.day}-${dateTime.month}-${dateTime.year}'),
//          onPressed: () {
//            _calendarController.setSelectedDay(
//              DateTime(dateTime.year, dateTime.month, dateTime.day),
//              runCallback: true,
//            );
//          },
//        ),
//      ],
//    );
//  }

  Widget _buildEventList(Map<DateTime, List> data){
    _selectedEvents = data[_selectedDay] ?? [];

    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: _selectedEvents.length,
      itemBuilder: (context, index) => _buildEventItem(_selectedEvents[index]),
    );
  }

  _buildEventItem(selectedEvent){
    List arr = selectedEvent.toString().split("@"); // slit event string by `@` character
    String lesson = arr[0];
    String subjectName = arr[1];
    String subjectClassName = arr[2];
    String address = arr[3];

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Tiết học: ', style: Theme.of(context).primaryTextTheme.subhead
                    .copyWith(color:textLightPrimary, fontWeight: FontWeight.bold),),
                Text(lesson, style: Theme.of(context).primaryTextTheme.subhead
                    .copyWith(color:textLightPrimary,),)
              ],
            ),
            Row(
              children: <Widget>[
                Text('Môn học: ', style: Theme.of(context).primaryTextTheme.subhead
                    .copyWith(color:textLightPrimary, fontWeight: FontWeight.bold),),
                Expanded(
                  child: Text(subjectClassName, style: Theme.of(context).primaryTextTheme.subhead
                      .copyWith(color:textLightPrimary,),),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Text('Địa điểm: ', style: Theme.of(context).primaryTextTheme.subhead
                    .copyWith(color:textLightPrimary, fontWeight: FontWeight.bold),),
                Text(address, style: Theme.of(context).primaryTextTheme.subhead
                    .copyWith(color:textLightPrimary,),)
              ],
            )
          ],
        ),
      ),
    );
  }
}

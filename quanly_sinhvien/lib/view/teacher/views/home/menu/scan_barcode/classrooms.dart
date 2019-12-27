import 'package:flutter/material.dart';
import 'package:quanly_sinhvien/bloc/bloc_classrooms.dart';
import 'package:quanly_sinhvien/model/response/classroom/classroom.dart';
import 'package:quanly_sinhvien/model/response/response_list_classroom.dart';
import 'package:quanly_sinhvien/utils/values/colors.dart';
import 'package:quanly_sinhvien/view/teacher/views/home/menu/scan_barcode/item_classroom.dart';
import 'package:quanly_sinhvien/view/widgets/error/err_connection.dart';
import 'package:quanly_sinhvien/view/widgets/loader/custom/loader_three_bounce.dart';

class Classrooms extends StatefulWidget {
  @override
  _ClassroomsState createState() => _ClassroomsState();
}

class _ClassroomsState extends State<Classrooms> {
  final _classroomsBloc= ClassroomsBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _classroomsBloc.getClassrooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Classrooms'),
      ),
      body: StreamBuilder<ResponseListClassroom>(
          stream: _classroomsBloc.streamClassrooms,
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return WidgetErrorConnection(snapshot.error.toString());
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting: return LoaderThreeBounce();
              case ConnectionState.active:
                if(snapshot.data.success){
                  return _buildListClass(snapshot.data.classrooms);
                }
                return  WidgetErrorConnection(snapshot.data.message.toString());
              case ConnectionState.done:
            }
            return null; // unreachable
          }
      ),
    );
  }

  _buildListClass(List<Classroom> classrooms) {
    return GridView.builder(
      itemCount: classrooms.length,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,),
      itemBuilder: (BuildContext context, int index) {
        return ClassroomItem(classrooms[index]);
      },
    );
  }
}

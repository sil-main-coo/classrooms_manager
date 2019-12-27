import 'dart:async';
import 'package:quanly_sinhvien/api/server/api_classroom.dart';
import 'package:quanly_sinhvien/model/response/response_list_classroom.dart';
import 'package:quanly_sinhvien/reponsitory_api/server/repo_classroom.dart';
import 'package:quanly_sinhvien/singleton/singletont_token.dart';

class ClassroomsBloc{
  StreamController<ResponseListClassroom> _streamClassrooms = StreamController();
  Stream get streamClassrooms => _streamClassrooms.stream;

  SingletonToken _tokenData= SingletonToken.getInstance();

  ClassroomRepo _api = ClassroomApi();

  getClassrooms() async {
    final response = await _api.getListClassroom(_tokenData.loginSession.token);
    if(response.success){
      _streamClassrooms.sink.add(response);
    }else{
      _streamClassrooms.sink.addError(response.message);
    }
  }

  dispose(){
    _streamClassrooms.close();
  }
}
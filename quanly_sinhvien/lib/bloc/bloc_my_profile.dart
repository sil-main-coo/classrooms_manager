import 'dart:async';
import 'package:quanly_sinhvien/api/server/api_user_data.dart';
import 'package:quanly_sinhvien/base/base_bloc.dart';
import 'package:quanly_sinhvien/base/base_event.dart';
import 'package:quanly_sinhvien/events/update_user_event.dart';
import 'package:quanly_sinhvien/model/response/response_result.dart';
import 'package:quanly_sinhvien/singleton/singletont_token.dart';

class MyProfileBloc extends BaseBloc{
  StreamController<ResponseResult> _streamCtrlUpdateUser = StreamController();
  Stream<ResponseResult> get streamUpdateUser => _streamCtrlUpdateUser.stream;

  StreamController<bool> _streamDisplayPhone = StreamController();
  Stream<bool> get streamDisplayPhone => _streamDisplayPhone.stream;
  Sink get sinkDisplayPhone => _streamDisplayPhone.sink;

  StreamController<bool> _streamDisplayMail = StreamController();
  Stream<bool> get streamDisplayMail => _streamDisplayMail.stream;
  Sink get sinkDisplayMail => _streamDisplayMail.sink;

  _updateUser(String key, String data) async {
    final SingletonToken singletonToken= SingletonToken.getInstance();
    final api= UserDataApi();
    final response= await api.updateUserProfile(singletonToken.loginSession.token,
        singletonToken.loginSession.idUser.toString(), key, data);
    _streamCtrlUpdateUser.sink.add(response);
    switch(key){
      case 'phone':
        _streamDisplayPhone.sink.add(true);
        break;
      case 'email':
        _streamDisplayMail.sink.add(true);
        break;
      default:
        throw Exception('Key update $key not yet build');
    }
  }

 @override
  void dispose() {
    // TODO: implement dispose
   _streamCtrlUpdateUser.close();
   _streamDisplayMail.close();
   _streamDisplayPhone.close();
    super.dispose();
  }

  @override
  void dispatchEvent(BaseEvent event) {
    // TODO: implement dispatchEvent
    if(event is UpdateUserEvent){
      _updateUser(event.key, event.data);
    }else{
      throw Exception('Wrong event:  ${event.toString()}');
    }
  }
}
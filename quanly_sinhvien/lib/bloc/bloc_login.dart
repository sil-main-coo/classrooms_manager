import 'dart:async';
import 'package:quanly_sinhvien/api/device/api_local_storage.dart';
import 'package:quanly_sinhvien/api/server/api_login_session.dart';
import 'package:quanly_sinhvien/reponsitory_api/server/repo_login_session.dart';
import 'package:quanly_sinhvien/utils/setups/local_storage_api/key_storage.dart';
import 'package:quanly_sinhvien/reponsitory_api/device/repo_local_storage.dart';
import 'package:quanly_sinhvien/base/base_bloc.dart';
import 'package:quanly_sinhvien/base/base_event.dart';
import 'package:quanly_sinhvien/utils//validator.dart';
import 'package:quanly_sinhvien/model/login_session.dart';
import 'package:quanly_sinhvien/model/response/response_login.dart';
import 'package:quanly_sinhvien/singleton/singletont_token.dart';
import 'package:quanly_sinhvien/model/request/account.dart';
import 'package:quanly_sinhvien/utils/values/name_role.dart';
import 'package:quanly_sinhvien/view/decentralize/login/event/login_event.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BaseBloc with Validators {
  final SingletonToken _singletonToken = SingletonToken.getInstance();
  LoginSessionRepoApi _api = LoginSessionApi();

  StreamController<String> _streamAccount = StreamController.broadcast();
  StreamController<String> _streamPwd = StreamController.broadcast();

  Sink<String> get accountChange => _streamAccount.sink;

  Sink<String> get pwdChange => _streamPwd.sink;

  Stream get account => _streamAccount.stream.transform(accountValidator);

  Stream get password => _streamPwd.stream.transform(pwdValidator);

  // Check account and pwd valid
  Stream<bool> get submitCheck =>
      Observable.combineLatest2(account, password, (a, p) => true);

  // ------------------ //
  StreamController<LoginResponse> _streamLogin = StreamController.broadcast();

  Stream<LoginResponse> get streamLogin =>
      _streamLogin.stream; // including login data: status, token, etc...

  _login(Account account, NameOfRole nameOfRole) async {
    final response = await _api.logIn(account);
    if (response.success) {
      // save token to local storage
      final LocalStorageRepo _apiStorage = LocalStorageApi();
      final loginSessionModel = LoginSessionModel(
          response.accessToken, nameOfRole, response.isOwner);
      final saved = await _apiStorage.saveData(
          KeyStorageApplication.tokenKey,
          loginSessionModel.toJson().toString());
      if (saved) {
        // add data to singleton
        _singletonToken.logIn(loginSessionModel);
      } else {
        throw Exception('Save login data missed');
      }
    }
    _streamLogin.add(response);
  }

  @override
  void dispatchEvent(BaseEvent event) {
    // TODO: implement dispatchEvent
    if (event is LoginEvent) {
      // login view.student
      _login(event.account, event.nameOfRole);
    } else {
      throw Exception('Event not yet defined');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamAccount.close();
    _streamPwd.close();
    _streamLogin.close();
  }

}
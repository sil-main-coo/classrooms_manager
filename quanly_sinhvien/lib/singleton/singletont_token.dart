import 'package:quanly_sinhvien/model/login_session.dart';

class SingletonToken{
  static final SingletonToken _instance = SingletonToken._();

  SingletonToken._();

  static getInstance() => _instance;

  LoginSessionModel _loginSession;
  LoginSessionModel get loginSession => _loginSession;

  bool _isLogin;

  bool get isLogin => _isLogin;

  logIn(LoginSessionModel loginSession){
    this._isLogin= true;
    this._loginSession= loginSession;
  }

  logOut(){
    this._isLogin= false;
    this._loginSession= null;
  }
}
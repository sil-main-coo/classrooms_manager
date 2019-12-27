import 'package:quanly_sinhvien/model/response/response_login.dart';
import 'package:quanly_sinhvien/model/request/account.dart';

abstract class LoginSessionRepoApi{
  Future<LoginResponse> logIn(Account account);
}
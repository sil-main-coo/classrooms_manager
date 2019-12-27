import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quanly_sinhvien/bloc/bloc_application.dart';
import 'package:quanly_sinhvien/bloc/bloc_login.dart';
import 'package:quanly_sinhvien/model/request/account.dart';
import 'package:quanly_sinhvien/utils//values/colors.dart';
import 'package:quanly_sinhvien/utils/values/name_role.dart';
import 'package:quanly_sinhvien/singleton/size_screen.dart';
import 'package:quanly_sinhvien/view/decentralize/login/event/login_event.dart';
import 'package:quanly_sinhvien/view/widgets/dialog/alert_result.dart';
import 'package:quanly_sinhvien/view/widgets/item_change_language.dart';
import 'package:quanly_sinhvien/view/widgets/loader/loading_dialog.dart';
import 'package:quanly_sinhvien/view/widgets/show_toast.dart';


class TeacherLogin extends StatefulWidget {
  @override
  _TeacherLoginState createState() => _TeacherLoginState();
}

class _TeacherLoginState extends State<TeacherLogin> {
  final _loginBloc= LoginBloc();
  final _ctrlUserName= TextEditingController();
  final _ctrlPwd= TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _loginBloc.dispose();
  }

  _login(BuildContext context) {
    // LOGIN TEACHER
    LoadingDialog.showLoadingDialog(context); // show loading
    _loginBloc.sinkEvent.add(
        LoginEvent(new Account(_ctrlUserName.text, _ctrlPwd.text, NameOfRole.TEACHER), NameOfRole.TEACHER)); // add event login teacher
    // listen result status login
    _loginBloc.streamLogin.listen((result) async {
      LoadingDialog.hideLoadingDialog(context);
      if(result.success) {
        final bloc= Provider.of<ApplicationBloc>(context);
        bloc.getMe(NameOfRole.TEACHER);
        Navigator.pushReplacementNamed(context, '/home', arguments: NameOfRole.TEACHER);
      }else
        AlertResult.showAlertError(context, result.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    final sc= SizeScreen.getSize(context);

    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _stickerTeacher(sc.height, sc.width),
                  _titleLogin(),
                  _boxLogin(context,  sc.height),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _stickerTeacher(double height, double width){
    final heightSticker= height/3.5;

    return SizedBox(
      height: heightSticker,
      child: Stack(
        children: <Widget>[
          Center(child: Image.asset('asset/image/teacherbg.png')),
          ChangeLanguageItem(),
        ],
      ),
    );
  }
  _titleLogin() {
    final style= TextStyle(color: textLightPrimary, fontSize: 26, fontFamily: 'Roboto Medium', fontWeight: FontWeight.w700);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Text('Teacher Login', style: style,),
    );
  }

  _boxLogin(BuildContext context, double height) {
    return Form(
      child: Column(
        children: <Widget>[
          _formInput(),
          SizedBox(height: height/14,),
          //_rememberForgot(),
          _buttonLogin(context, height),
          _changeRole(context, height),
        ],
      ),
    );
  }

  _formInput() {
    return Column(
      children: <Widget>[
        StreamBuilder<String>(
            stream: _loginBloc.account,
            builder: (context, snapshot) {
              return TextField(
                controller: _ctrlUserName,
                onChanged: (value){
                  _loginBloc.accountChange.add(value);
                },
                decoration: InputDecoration(
                  errorText: snapshot.error,
                  labelText: "Account",
                  labelStyle: TextStyle(color: secondaryLight),
                  prefixIcon: Icon(Icons.person, color: secondaryLight,),
                ),
              );
            }
        ),
        StreamBuilder<String>(
            stream: _loginBloc.password,
            builder: (context, snapshot) {
              return TextField(
                controller: _ctrlPwd,
                onChanged: (value){
                  _loginBloc.pwdChange.add(value);
                },
                obscureText: true,
                decoration: InputDecoration(
                  errorText: snapshot.error,
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock, color: secondaryLight,),
                ),
              );
            }
        ),
      ],
    );
  }

  _rememberForgot() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 32),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Checkbox(
                  value: true,
                  activeColor: primaryLight,
                  onChanged: (isCheck){
                    // todo
                  },
                ),
                Text("Remember Me",),
              ],
            ),
          ),
          Text("Forgot Password")
        ],
      ),
    );
  }

  _buttonLogin(BuildContext context, double height) {
    return SizedBox(
      width: double.infinity,
      height: height/12,
      child: StreamBuilder<bool>(
          stream: _loginBloc.submitCheck,
          builder: (context, snapshot) {
            print(snapshot.data.toString());
            return RaisedButton(
              onPressed:  ()=> _login(context),
              disabledColor: Colors.grey,
              child: Text('LOGIN', style: Theme.of(context).primaryTextTheme.button
              ),
              color: primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            );
          }
      ),
    );
  }

  _changeRole(BuildContext context, double height) {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: SizedBox(
        height: height/14,
        child: FlatButton.icon(
          onPressed: (){
            Navigator.pushNamed(context, '/login/view.student');
          },
          icon: Icon(Icons.undo),
          label: Text('Are you a student?', style: Theme.of(context).primaryTextTheme.button
          ),
          textColor: Colors.white,
          color: secondary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
      ),
    );
  }
}

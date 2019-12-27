import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quanly_sinhvien/bloc/bloc_application.dart';
import 'package:quanly_sinhvien/bloc/bloc_my_profile.dart';
import 'package:quanly_sinhvien/events/update_user_event.dart';
import 'package:quanly_sinhvien/utils/values/colors.dart';
import 'package:quanly_sinhvien/model/response/profile/student_profile.dart';
import 'package:quanly_sinhvien/singleton/size_screen.dart';

class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}


class _MyProfilePageState extends State<MyProfilePage> {
  final _profileBloc= MyProfileBloc();
  final _ctrlEdPhone= TextEditingController();
  final _ctrEdMail= TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<ApplicationBloc>(context);
    final profile = bloc.profileStudent;
    final sc= SizeScreen.getSize(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildHeader(context, profile, sc.height),
            _buildBody(profile)
          ],
        ),
      )
    );
  }

  _buildHeader(BuildContext context, StudentProfile profile, double height) {
    final heightBox= height/2.4;

    return Container(
      height:heightBox,
      child: Stack(
        children: <Widget>[
          _buildBgColor(),
          _buildAppbarHeader(context),
          _buildContentHeader(context, profile, heightBox),
        ],
      ),
    );
  }

  _buildBgColor(){
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [secondaryDark, primary]
          )
      ),
    );
  }


  _buildAppbarHeader(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topLeft,
        child: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: (){
          Navigator.pop(context);
        }),
      ),
    );
  }


  _buildContentHeader(BuildContext context, StudentProfile profile, double heightBox){
    return SafeArea(
      child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _avatar(heightBox),
            _fullName(context, profile.name),
          ],
        )
      ),
    );
  }

  _avatar(double heightBox) {
    final sizeAvatar= heightBox/2;

    return Container(
      width: sizeAvatar,
      height: sizeAvatar,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(90.0),
        child: new Image.asset(
          "asset/image/logo.png",
          fit: BoxFit.cover,
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90.0),
        border: Border.all(
          color: Colors.white,
          width: 4.0,
        ),
      ),
    );
  }

  _fullName(BuildContext context, String name){
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(name, style: Theme.of(context).primaryTextTheme.title.copyWith(fontWeight: FontWeight.bold),),
    );
  }

  _buildBody(StudentProfile profile) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.person, color: primary,),
              title: Text(profile.username),
            ),
            ListTile(
              leading: Icon(Icons.credit_card, color: primary,),
              title: Text(profile.major),
            ),
            ListTile(
              leading: Icon(Icons.class_, color: primary,),
              title: Text(profile.className),
            ),
            StreamBuilder<bool>(
              initialData: true,
              stream: _profileBloc.streamDisplayPhone,
              builder: (context, snapshot) {
                return Stack(
                  children: <Widget>[
                    _buildDisplayPhone(profile, snapshot.data),
                    _buildEditPhone(profile, snapshot.data)
                  ],
                );
              }
            ),
            StreamBuilder<bool>(
              initialData: true,
              stream: _profileBloc.streamDisplayMail,
              builder: (context, snapshot) {
                return Stack(
                  children: <Widget>[
                    _buildDisplayMail(profile, snapshot.data),
                    _buildEditMail(profile, snapshot.data)
                  ],
                );
              }
            ),
          ],
        ),
      ),
    );
  }

  _buildDisplayPhone(StudentProfile profile, bool data){
    return Visibility(
      visible: data,
      child: ListTile(
        leading: Icon(Icons.phone, color: primary,),
        title: Text("${profile.phone}"),
//        trailing: IconButton(
//          icon: Icon(Icons.edit),
//          onPressed: (){
//            _profileBloc.sinkDisplayPhone.add(false);
//          },
//        ),
      ),
    );
  }

  _buildEditPhone(StudentProfile profile, bool data){
    return  Visibility(
      visible: !data,
      child: ListTile(
        leading: Icon(Icons.phone, color: primary,),
        title: TextFormField(
          controller: _ctrlEdPhone,
        ),
        trailing: IconButton(
          icon: Icon(Icons.save),
          onPressed: (){

          },
        ),
      ),
    );
  }

  _buildDisplayMail(StudentProfile profile, bool data){
    return  Visibility(
      visible: data,
      child: ListTile(
        leading: Icon(Icons.email, color: primary,),
        title: Text("${profile.email}"),
//        trailing: IconButton(
//          icon: Icon(Icons.edit),
//          onPressed: (){
//            _profileBloc.sinkDisplayMail.add(false);
//          },
//        ),
      ),
    );
  }

  _buildEditMail(StudentProfile profile, bool data){
    return Visibility(
          visible: !data,
          child: ListTile(
            leading: Icon(Icons.mail, color: primary,),
            title: TextFormField(
              controller: _ctrEdMail,
            ),
            trailing: IconButton(
              icon: Icon(Icons.save),
              onPressed: (){

              },
            ),
          ),
    );
  }

  _updateProfile(String key, String data,){
    _profileBloc.sinkEvent.add(UpdateUserEvent(key, data));
  }

}

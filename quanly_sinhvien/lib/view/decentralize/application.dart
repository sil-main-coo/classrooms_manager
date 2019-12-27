import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quanly_sinhvien/bloc/bloc_application.dart';
import 'package:quanly_sinhvien/singleton/singletont_token.dart';
import 'package:quanly_sinhvien/view/decentralize/home/home.dart';
import 'package:quanly_sinhvien/view/decentralize/pick_role.dart';
import 'package:quanly_sinhvien/view/widgets/loader/custom/loader_circle.dart';

class ApplicationPage extends StatefulWidget {
  @override
  _ApplicationPageState createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  ApplicationBloc _bloc;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    _bloc = Provider.of<ApplicationBloc>(context);
    _bloc.getTokenFromLocal();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<SingletonToken>(
            stream: _bloc.streamCheckLogin,
            builder: (context, snapshot) {
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting: return LoaderCircle();
                case ConnectionState.active:
                  if(snapshot.data.isLogin){
                    _bloc.getMe(snapshot.data.loginSession.nameOfRole);
                    return HomePage(snapshot.data.loginSession.nameOfRole);
                  }
                  return PickYourRole();
                case ConnectionState.done:
              }
              return null; // unreachable
            }
        )
    );
  }
}

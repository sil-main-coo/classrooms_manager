import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:quanly_sinhvien/bloc/bloc_application.dart';
import 'package:quanly_sinhvien/check/check_i_connecting.dart';
import 'package:quanly_sinhvien/utils/values/colors.dart';
import 'package:quanly_sinhvien/route.dart';
import 'package:provider/provider.dart';

void main(){
  // Khái báo và khởi tạo singleton theo dõi thay đổi kết nối internet
  ConnectionStatusSingleton _connStt= ConnectionStatusSingleton.getInstance();
  _connStt.initialize();
  return runApp(EasyLocalization(child: MyApp())); // add multi language
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data; // data multi language

    return MultiProvider(
        providers: [
          Provider<ApplicationBloc>(create: (_) => ApplicationBloc()),
        ],
        child: EasyLocalizationProvider(
          data: data,
          child: MaterialApp(
            title: 'Flutter Demo',
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              //app-specific localization
              EasylocaLizationDelegate(
                  locale: data.locale,
                  path: 'resources/langs'),
            ],
            supportedLocales: [Locale('en', 'US'), Locale('vi', 'VI')],
            locale: data.savedLocale,
            theme: ThemeData(
              primaryColor: primary,
              primaryColorDark: primaryDark,
              primaryColorLight: primaryLight,
              accentColor: secondary,
              indicatorColor: secondaryLight,
              focusColor: secondaryLight,
              disabledColor: secondaryLight,
              hintColor: secondaryLight,
              cursorColor: primary,
              iconTheme: IconThemeData(
                color: Colors.white
              ),
              inputDecorationTheme: InputDecorationTheme(
                labelStyle: TextStyle(color: secondaryLight),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: secondary),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: secondaryLight),
                ),
              ),
              primaryTextTheme: TextTheme(
                title: TextStyle(color: textDarkPrimary, fontSize: 20, fontFamily: 'Roboto Medium'),
                headline: TextStyle(color: textDarkPrimary, fontSize: 24, fontFamily: 'Roboto Regular'),
                subhead: TextStyle(color: textDarkPrimary, fontSize: 16, fontFamily: 'Roboto Regular'),
                body2:  TextStyle(color: textDarkPrimary, fontSize: 14, fontFamily: 'Roboto Medium'),
                body1: TextStyle(color: textDarkPrimary, fontSize: 20, fontFamily: 'Roboto Regular'),
                caption: TextStyle(color: textDarkPrimary, fontSize: 12, fontFamily: 'Roboto Regular'),
                button: TextStyle(color: textDarkPrimary, fontSize: 14, fontFamily: 'Roboto Medium'),
              ),
              primaryIconTheme: IconThemeData(
                  color: Colors.white
              ),
              accentIconTheme: IconThemeData(
                  color: textDarkPrimary
              )
            ),
            initialRoute: "/",
            debugShowCheckedModeBanner: false,
            onGenerateRoute: Router.onGenerateRoute,
          ),
        ),
    );
  }
}


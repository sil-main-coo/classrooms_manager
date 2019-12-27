
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:quanly_sinhvien/singleton/size_screen.dart';

class ChangeLanguageItem extends StatefulWidget {
  @override
  _ChangeLanguageItemState createState() => _ChangeLanguageItemState();
}

class _ChangeLanguageItemState extends State<ChangeLanguageItem> {
  @override
  Widget build(BuildContext context) {
    final sc= SizeScreen.getSize(context);
    var localProvider = EasyLocalizationProvider.of(context);
    var langCode= Localizations.localeOf(context).languageCode;

    return EasyLocalizationProvider(
      data: localProvider.data,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              child: Column(
                children: <Widget>[
                  Container(
                    height: sc.width/15,
                    width: sc.width/15,
                    color: langCode== 'en'? Colors.blue : Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text("Eng"),
                  )
                ],
              ),
              onTap: () => _setEngLang(localProvider)
            ),
          ),
          GestureDetector(
            onTap: () =>_setViLang(localProvider),
            child: Column(
              children: <Widget>[
                Container(
                  height: sc.width/15,
                  width: sc.width/15,
                  color: langCode== 'vi'? Colors.blue : Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text("Vi"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }


  _setViLang(localProvider) {
    this.setState(() {
      localProvider.data.changeLocale(Locale("vi", "VI"));
      print(Localizations.localeOf(context).languageCode);
    });
  }

  _setEngLang(localProvider) {
    setState(() {
      print(Localizations.localeOf(context).languageCode);
      print(localProvider.data.toString());
      localProvider.data.changeLocale(Locale("en", "US"));
      print(Localizations.localeOf(context).languageCode);
    });
  }
}

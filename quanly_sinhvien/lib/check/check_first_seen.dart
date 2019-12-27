import 'package:shared_preferences/shared_preferences.dart';

class CheckFirstSeen{
  Future<bool> checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seenGet = (prefs.getBool('seen') ?? false);
    prefs.setBool('seen', true);
    return _seenGet;
  }
}
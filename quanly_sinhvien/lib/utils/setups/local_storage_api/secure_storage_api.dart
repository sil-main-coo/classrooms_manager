import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppSecureStorage{
  final _storage = new FlutterSecureStorage();

  static AppSecureStorage _instance;

  AppSecureStorage._();

  static AppSecureStorage getInstance(){
    if(_instance == null){
      _instance=  AppSecureStorage._();
    }
    return _instance;
  }

  Future<void> persistData(String key, String value) async {
    return _storage.write(key: key, value: value);
  }

  // Get value from SecureStorage
  Future<String> retrieveData(String key) async {
    final value=  await _storage.read(key: key);
    return value;
  }

  Future<void> deleteData(String key) async {
    _storage.delete(key: key);
  }
}
import 'dart:io';
class CheckConnection{
  static Future<bool> checkConnection() async {
    bool hasConn;
    try{
      final result= await InternetAddress.lookup("google.com");
      if(result.isNotEmpty && result[0].rawAddress.isNotEmpty){
        hasConn= true;
      }else{
        hasConn= false;
      }
    }on SocketException catch(_){
      hasConn= false; // Khi ko conn đc
    }
    return hasConn;
  }
}
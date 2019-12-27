import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';

/**
 * Singleton lắng nghe sự thay dổi của kết nối internet.
 * Từ đó đưa ra giao diện realtime
 * Sử dụng tương tác người dùng khi thay đổi cài đặt intennet
 */

class ConnectionStatusSingleton{
  static final ConnectionStatusSingleton _statusSingleton= new ConnectionStatusSingleton._internal();

  ConnectionStatusSingleton._internal();

  static ConnectionStatusSingleton getInstance() => _statusSingleton;

  // Stream
  StreamController _controller = new StreamController.broadcast();
  Stream get streamConnChange => _controller.stream; // return value if connection has been changed

  // Flutter connectivity
  Connectivity _connectivity = new Connectivity();
  bool hasConn = false;


  void initialize(){
    _connectivity.onConnectivityChanged.listen(_onChange);
    _checkConnection();
  }

  void _onChange(ConnectivityResult event) {
    _checkConnection();
  }

  void dispose(){
    _controller.close();
  }

  Future<bool> _checkConnection() async {
    bool preConn= hasConn;
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

    // Nếu có sự thay đổi thì đổi trạng thái
    if(preConn != hasConn){
      _controller.add(hasConn); // Đổ lại đầu vào
    }

    return hasConn;
  }
}
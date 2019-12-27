import 'package:flutter/cupertino.dart';

class SizeScreen{
  static SizeScreen _instance;
  static double _width, _height;

  double get width => _width;

  double get height => _height;

  SizeScreen._();

  static SizeScreen getSize(BuildContext context){
    debugPrint('>>> START GET SIZE');
    if(_instance==null || _height ==0 || _width==0  ){
      debugPrint('>>> INSTANCE == NULL');
      debugPrint('>>> HEIGHT NULL = $_height');
      _instance= SizeScreen._();
      final size= MediaQuery.of(context).size; // run
      _width= size.width;
      _height= size.height;

      debugPrint('>>> HEIGHT = $_height');
      return _instance;
    }

    debugPrint('>>> HEIGHT NOT NULL = $_height');
    return _instance;
  }
}
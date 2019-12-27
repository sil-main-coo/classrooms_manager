import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quanly_sinhvien/base/base_event.dart';

// use again base bloc
abstract class BaseBloc{
  StreamController<BaseEvent> _streamEvent = StreamController();
  Sink<BaseEvent> get sinkEvent => _streamEvent.sink;

  BaseBloc(){
    // listen event
    _streamEvent.stream.listen((event){
      if(event is! BaseEvent)
        throw Exception('Event is invalid');
      else
        dispatchEvent(event);
    });
  }

  void dispatchEvent(BaseEvent event);

  @mustCallSuper
  void dispose(){
    _streamEvent.close();
  }
}
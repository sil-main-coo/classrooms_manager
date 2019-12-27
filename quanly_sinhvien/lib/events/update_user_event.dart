import 'package:quanly_sinhvien/base/base_event.dart';

class UpdateUserEvent extends BaseEvent{
  String _key, _data;

  UpdateUserEvent(this._key, this._data);

  get data => _data;

  String get key => _key;

}
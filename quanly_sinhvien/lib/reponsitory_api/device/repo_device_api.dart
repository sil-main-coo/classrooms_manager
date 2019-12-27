import 'package:location/location.dart';

abstract class DeviceRepo{
  Future<String> getIMEI();
  Future<LocationData> getCurrentLocation();
  Future<String> scanQRCode();
}
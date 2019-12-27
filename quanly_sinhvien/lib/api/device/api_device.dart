import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:quanly_sinhvien/reponsitory_api/device/repo_device_api.dart';

class DeviceApi implements DeviceRepo {

  // This method is future get current location of your device
  // return a [LocationData]
  @override
  Future<LocationData> getCurrentLocation() async {
    var location = new Location();

    try {
      final currentLocation = await location.getLocation();
      return currentLocation;
    } catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        throw Exception('Permission denied');
      }
    }

    return null;
  }

  // This method get imei device
  // return String
  @override
  Future<String> getIMEI() async {
    try {
      final imei = await ImeiPlugin.getImei(
          shouldShowRequestPermissionRationale: false);
      debugPrint('Device IMEI: $imei');
      return imei;
      // _id = await ImeiPlugin.getId();
    } on PlatformException {
      throw Exception('Failed to get platform version.');
    }
  }

  // This is future handling scan QRCode
  // It's returns 1 a string.
  @override
  Future<String> scanQRCode() async {
    try {
      final barcode = await BarcodeScanner.scan();
      debugPrint("this is barcode: $barcode");
      return barcode;
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        throw Exception('The user did not grant the camera permission!');
      }else {
        return null;
      }
    } on FormatException {
      throw Exception(
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }

}
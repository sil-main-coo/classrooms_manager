class AttendanceData {
  String code;
  String lat;
  String lon;
  String imei;

  AttendanceData({this.code, this.lat, this.lon, this.imei});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['imei'] = this.imei;
    return data;
  }
}
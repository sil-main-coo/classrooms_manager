class User {
  String _sId;
  String _username;
  String _password;
  String _name;
  String _role;
  String _accessToken;
  String _phone;
  String _email;
  int _iV;

  User.fromJson(Map<String, dynamic> json) {
    _sId = json['_id'];
    _username = json['username'];
    _password = json['password'];
    _name = json['name'];
    _role = json['role'];
    _phone= json['phone'];
    _email= json['email'];
    _accessToken = json['access_token'];
    _iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this._sId;
    data['username'] = this._username;
    data['password'] = this._password;
    data['name'] = this._name;
    data['role'] = this._role;
    data['phone'] = this._email;
    data['email'] = this._phone;
    data['access_token'] = this._accessToken;
    data['__v'] = this._iV;
    return data;
  }

  int get iV => _iV;

  String get accessToken => _accessToken;

  String get role => _role;

  String get name => _name;

  String get password => _password;

  String get username => _username;

  String get sId => _sId;

  String get email => _email;

  String get phone => _phone;


}
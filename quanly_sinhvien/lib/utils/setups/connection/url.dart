class AppURL{
  static const _HOST_ADDRESS= 'http://167.179.113.63';
  static const _PORT_NAME= '3000';
  static const _SERVER_ADDRESS= _HOST_ADDRESS + ':' +_PORT_NAME;
  static const _END_POINT= _SERVER_ADDRESS + '/api';

  static const login= _END_POINT + '/login';
  static const getRoles= _END_POINT + '/roles';
  static const getMe= _END_POINT + '/me';
  static const user= _END_POINT + '/users';
  static const schedule= _END_POINT + '/me/schedule';
  static const classrooms= _END_POINT + '/classrooms';

}
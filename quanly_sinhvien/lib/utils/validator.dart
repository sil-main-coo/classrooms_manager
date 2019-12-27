import 'dart:async';

class Validators{
  var accountValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (acc, sink){
      if(acc.length>4)
        sink.add(acc);
      else
        sink.addError('Email is not valid');
    }
  );

  var pwdValidator= StreamTransformer<String, String>.fromHandlers(
    handleData: (pwd, sink){
      if(pwd.length>4)
        sink.add(pwd);
      else
        sink.addError('Password is not valid');
    }
  );
}
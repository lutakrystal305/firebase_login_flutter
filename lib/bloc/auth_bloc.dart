import 'dart:async';

import 'package:cart_shopping/firebase/firebase_auth.dart';

class AuthBloc {
  // ignore: prefer_final_fields
  var _fbaseAuth = FbaseAuth();

  final StreamController _nameController = StreamController();
  final StreamController _emailController = StreamController();
  final StreamController _passController = StreamController();
  final StreamController _phoneController = StreamController();

  Stream get nameStream => _nameController.stream;
  Stream get emailStream => _emailController.stream;
  Stream get passStream => _passController.stream;
  Stream get phoneStream => _phoneController.stream;

  bool isValid(String name, String email, String pass, String phone) {
    // ignore: unnecessary_null_comparison
    if (name == null || name.isEmpty) {
      _nameController.sink.addError('Name is invalid!');
      return false;
    }
    _nameController.sink.add('');
    // ignore: unnecessary_null_comparison
    if (phone == null || phone.isEmpty) {
      _phoneController.sink.addError('Phone Number is invalid!');
      return false;
    }
    _phoneController.sink.add('');
    // ignore: unnecessary_null_comparison
    if (email == null || email.length < 8 || !email.contains('@gmail')) {
      _emailController.sink.addError('Email is invalid!');
      return false;
    }
    _emailController.sink.add('');
    // ignore: unnecessary_null_comparison
    if (pass == null || pass.length < 6) {
      _passController.sink.addError('Password is invalid!');
      return false;
    }
    _passController.sink.add('');
    return true;
  }

  void signUp(String email, String pass, String name, String phone,
      Function onSuccess, Function(String) onSignUpError) {
    _fbaseAuth.signUp(email, pass, name, phone, onSuccess, onSignUpError);
  }

  void signIn(String email, String pass, Function onSuccess,
      Function(String) onSignInError) {
    _fbaseAuth.signIn(email, pass, onSuccess, onSignInError);
  }

  void dispose() {
    _nameController.close();
    _emailController.close();
    _passController.close();
    _phoneController.close();
  }
}

import 'dart:async';
import 'package:flutter_application_1/src/fire_base/fire_base_auth.dart';

class AuthBloc {
  final _firAuth = FirAuth();

  final StreamController _nameController = StreamController();
  final StreamController _phoneController = StreamController();
  final StreamController _emailController = StreamController();
  final StreamController _passController = StreamController();

  Stream get nameStream => _nameController.stream;
  Stream get phoneStream => _phoneController.stream;
  Stream get emailStream => _emailController.stream;
  Stream get passStream => _passController.stream;

  bool isValid(String name, String phone, String email, String pass) {
    if (name.isEmpty) {
      _nameController.sink.add("Nhap ten");
      return false;
    }
    _nameController.sink.add("");

    if (phone.isEmpty) {
      _phoneController.sink.add("Nhap so dien thoai");
      return false;
    }
    _phoneController.sink.add("");

    if (email.isEmpty) {
      _emailController.sink.add("Nhap email");
      return false;
    }
    _emailController.sink.add("");

    if (pass.isEmpty || pass.length < 6) {
      _passController.sink.add("Mat khau phai tren 5 ki tu");
      return false;
    }
    _passController.sink.add("");

    return true;
  }

  void signUp(String email, String pass, String phone, String name,
      Function onSuccess, Function(String) onRegisterError) {
    _firAuth.signUp(email, pass, phone, name, onSuccess, onRegisterError);
  }

  void signIn(String email, String pass, Function onSuccess,
      Function(String) onSignInError) {
    _firAuth.signIn(email, pass, onSuccess, onSignInError);
  }

  void dispose() {
    _nameController.close();
    _emailController.close();
    _phoneController.close();
    _passController.close();
  }
}

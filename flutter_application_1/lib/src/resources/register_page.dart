import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/blocs/auth_bloc.dart';
import 'package:flutter_application_1/src/resources/home_page.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:logger/logger.dart';

class MyRegisterPage extends StatefulWidget {
  MyRegisterPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyRegisterPage();
  }
}

class _MyRegisterPage extends State<MyRegisterPage> {
  Logger logger = Logger();
  AuthBloc authBloc = AuthBloc();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  void dispose() {
    authBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Container(
          color: Colors.white,
          width: 500,
          height: 700,
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(children: [
              const Text(
                'Welcome!',
                style: TextStyle(fontSize: 20),
              ),
              const Text(
                'Signup in simple steps',
                style: TextStyle(fontSize: 14),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 80, 0, 20),
                child: StreamBuilder(
                  stream: authBloc.nameStream,
                  builder: (context, snapshot) => TextField(
                    controller: _nameController,
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                      errorText:
                          snapshot.hasError ? snapshot.error.toString() : null,
                      labelText: 'Name',
                      prefixIcon: Container(
                        width: 50,
                        child: const Icon(FontAwesome.user),
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                    ),
                  ),
                ),
              ),
              StreamBuilder(
                stream: authBloc.phoneStream,
                builder: (context, snapshot) => TextField(
                  controller: _phoneController,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  decoration: InputDecoration(
                    errorText:
                        snapshot.hasError ? snapshot.error.toString() : null,
                    labelText: 'Phone',
                    prefixIcon: Container(
                      width: 50,
                      child: const Icon(FontAwesome.phone),
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: StreamBuilder(
                  stream: authBloc.emailStream,
                  builder: (context, snapshot) => TextField(
                    controller: _emailController,
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                      errorText:
                          snapshot.hasError ? snapshot.error.toString() : null,
                      labelText: 'Email',
                      prefixIcon: Container(
                        width: 50,
                        child: const Icon(FontAwesome.envelope),
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                    ),
                  ),
                ),
              ),
              StreamBuilder(
                stream: authBloc.passStream,
                builder: (context, snapshot) => TextField(
                  controller: _passController,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  decoration: InputDecoration(
                    errorText:
                        snapshot.hasError ? snapshot.error.toString() : null,
                    labelText: 'Password',
                    prefixIcon: Container(
                      width: 50,
                      child: const Icon(FontAwesome.lock),
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 40),
                child: ElevatedButton(
                  onPressed: _onSignUpClicked,
                  child: const Text('SIGN UP'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: RichText(
                  text: const TextSpan(
                      text: "Already a User? ",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                          text: "Login now",
                          style: TextStyle(color: Colors.blue, fontSize: 16),
                        ),
                      ]),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  _onSignUpClicked() {
    var isValid = authBloc.isValid(_nameController.text, _phoneController.text,
        _emailController.text, _passController.text);
    if (isValid) {
      // create user here
      authBloc.signUp(_emailController.text, _passController.text,
          _phoneController.text, _nameController.text, () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ));
      });
    }
  }
}

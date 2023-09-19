import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/app.dart';
import 'package:flutter_application_1/src/resources/dialog/loading_dialog.dart';
import 'package:flutter_application_1/src/resources/dialog/msg_dialog.dart';
import 'package:flutter_application_1/src/resources/home_page.dart';
import 'package:flutter_application_1/src/resources/register_page.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:logger/logger.dart';

class MyLoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyLoginPage();
  }
}

class _MyLoginPage extends State<MyLoginPage> {
  final Logger logger = Logger();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

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
                'Login',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                alignment: AlignmentDirectional.bottomStart,
                child: const Text('Username'),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Type your username',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ),
              Container(
                alignment: AlignmentDirectional.bottomStart,
                child: const Text('Password'),
              ),
              TextField(
                controller: _passController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Type your password',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    logger.d('Forgot password tapped');
                  },
                  child: const Text('Forgot password?'),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  _onLoginClick();
                },
                child: const Text('LOGIN'),
              ),
              const SizedBox(height: 60.0),
              const Text(
                'Or Sign Up Using',
                style: TextStyle(fontSize: 12.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      logger.d('Login with Facebook');
                    },
                    icon: const Icon(FontAwesome.facebook),
                  ),
                  IconButton(
                    onPressed: () {
                      logger.d('Login with Twitter');
                    },
                    icon: const Icon(FontAwesome.twitter),
                  ),
                  IconButton(
                    onPressed: () {
                      logger.d('Login with Google');
                    },
                    icon: const Icon(FontAwesome.google),
                  ),
                ],
              ),
              const SizedBox(
                height: 100.0,
              ),
              const Text(
                'Or Sign Up Using',
                style: TextStyle(fontSize: 12.0),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyRegisterPage()));
                },
                child: const Text('SIGN UP'),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void _onLoginClick() {
    String email = _emailController.text;
    String pass = _passController.text;
    var authBloc = MyApp.of(context)!.authBloc;

    LoadingDialog.showLoadingDialog(context, "Loading...");
    authBloc.signIn(email, pass, () {
      LoadingDialog.hideLoadingDialog(context);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
    }, (msg) {
      LoadingDialog.hideLoadingDialog(context);
      MsgDialog.showMsgDialog(context, "Sign in", msg);
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/app.dart';
import 'package:flutter_application_1/src/resources/dialog/loading_dialog.dart';
import 'package:flutter_application_1/src/resources/dialog/msg_dialog.dart';
import 'package:flutter_application_1/src/resources/forgot_pw_page.dart';
import 'package:flutter_application_1/src/resources/home_page.dart';
import 'package:flutter_application_1/src/resources/register_page.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:logger/logger.dart';

class MyLoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<MyLoginPage> {
  final Logger logger = Logger();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _emailInvalid = false;
  bool _passInvalid = false;

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
                child: const Text('Email'),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Type your email',
                    prefixIcon: const Icon(Icons.person),
                    errorText: _emailInvalid ? "Invalid email" : null,
                  ),
                  onSubmitted: (value) {
                    setState(() {
                      RegExp emailRegExp = RegExp(
                          r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                      _emailInvalid = !emailRegExp.hasMatch(value);
                    });
                  },
                ),
              ),
              Container(
                alignment: AlignmentDirectional.bottomStart,
                child: const Text('Password'),
              ),
              TextField(
                controller: _passController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Type your password',
                  prefixIcon: const Icon(Icons.lock),
                  errorText: _passInvalid ? "Invalid password" : null,
                ),
                onSubmitted: (value) {
                  setState(() {
                    RegExp passwordRegExp =
                        RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$');
                    _passInvalid = !passwordRegExp.hasMatch(value);
                  });
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPasswordPage()));
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
                      _onLoginWithFacebookClick();
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
                      _onLoginWithGoogleClick();
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
    var _authBloc = MyApp.of(context)!.authBloc;

    LoadingDialog.showLoadingDialog(context, "Loading...");
    _authBloc.signIn(_emailController.text, _passController.text, () {
      LoadingDialog.hideLoadingDialog(context);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
    }, (msg) {
      LoadingDialog.hideLoadingDialog(context);
      MsgDialog.showMsgDialog(context, "Sign in", msg);
    });
  }

  void _onLoginWithGoogleClick() {
    var _authBloc = MyApp.of(context)!.authBloc;

    LoadingDialog.showLoadingDialog(context, "Loading...");
    _authBloc.signInWithGoogle(() {
      LoadingDialog.hideLoadingDialog(context);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
    }, (msg) {
      LoadingDialog.hideLoadingDialog(context);
      MsgDialog.showMsgDialog(context, "Sign in with Google", msg);
    });
  }

  void _onLoginWithFacebookClick() {
    var _authBloc = MyApp.of(context)!.authBloc;

    LoadingDialog.showLoadingDialog(context, "Loading...");
    _authBloc.signInWithFacebook(() {
      LoadingDialog.hideLoadingDialog(context);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
    }, (msg) {
      LoadingDialog.hideLoadingDialog(context);
      MsgDialog.showMsgDialog(context, "Sign in with Facebook", msg);
    });
  }
}

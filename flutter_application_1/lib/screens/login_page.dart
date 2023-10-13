import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/login_bloc.dart';
import 'package:flutter_application_1/screens/forget_password.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/login_option.dart';
import 'package:flutter_application_1/screens/sign_up_page.dart';
import 'package:flutter_application_1/utils/navigate_page.dart';
import 'package:flutter_application_1/utils/popup.dart';
import 'package:flutter_application_1/utils/validate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key}) : super(key: key);
  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  bool emailValid = false;
  late LoginBloc loginBloc;
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    loginBloc = LoginBloc();
  }

  @override
  Widget build(BuildContext context) {
    // print(loginBloc.state);
    var emailContrl = TextEditingController();
    var passwordContrl = TextEditingController();
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Sign in',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Column(children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'username',
                    style: TextStyle(fontSize: 20),
                    // set this to left of screen
                  ),
                ),
              ]),
            ),
            Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person),
                          hintText: 'Enter your username',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          errorText: emailValid ? 'Invalid username' : null,
                        ),
                        onSubmitted: (value) {
                          setState(() {
                            emailValid = !validateEmail(value);
                          });
                        },
                        controller: emailContrl,
                      ),
                    )
                  ],
                )),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'password',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ]),
            ),
            Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      alignment: Alignment.centerLeft,
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          hintText: 'Enter your password',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                        ),
                        controller: passwordContrl,
                      ),
                    ),
                  ],
                )),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  navigatePage(context, const ForgetPasswordPage());
                },
                child: const Text('Forgot password?',
                    style: TextStyle(fontSize: 15, color: Colors.black)),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (emailContrl.text.isEmpty || passwordContrl.text.isEmpty) {
                    return;
                  } else {
                    // loginWithEmail(context, emailContrl, passwordContrl);
                    loginBloc.add(LoginButtonPressed(
                        email: emailContrl.text,
                        password: passwordContrl.text));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 216, 36, 126),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Log in',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            BlocBuilder<LoginBloc, LoginState>(
                bloc: loginBloc,
                builder: (context, state) {
                  if (state is LoginSuccess) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      navigatePage(context, MyHomePage(user: state.user));
                    });
                  } else if (state is LoginFailure) {
                    return showdialog(context, 'Sign in', state.error);
                  } else if (state is LoginLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Container();
                }),
            Container(
              padding: const EdgeInsets.only(top: 10, bottom: 0),
              alignment: Alignment.center,
              child: Text('Or sign in with',
                  style: TextStyle(fontSize: 15, color: Colors.grey[400])),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    padding: const EdgeInsets.all(5),
                    onPressed: () async {
                      try {
                        loginBloc.add(FacebookLoginPress());
                      } catch (e) {
                        print(e);
                      }
                    },
                    icon: Icon(
                      FontAwesomeIcons.facebook,
                      size: 40,
                      color: Colors.blue[900],
                    )),
                IconButton(
                    padding: const EdgeInsets.all(5),
                    onPressed: () {
                      // FirebaseAuth.instance.;
                    },
                    icon: Icon(
                      FontAwesomeIcons.google,
                      size: 40,
                      color: Colors.red[900],
                    )),
                IconButton(
                    padding: const EdgeInsets.all(5),
                    onPressed: () {},
                    icon: const Icon(
                      FontAwesomeIcons.twitter,
                      size: 40,
                      color: Colors.blue,
                    )),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              alignment: Alignment.center,
              child: Text('Or sign in with',
                  style: TextStyle(fontSize: 15, color: Colors.grey[400])),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MySignUpPage()));
                },
                child: const Text('Sign up',
                    style: TextStyle(fontSize: 20, color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

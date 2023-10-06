import 'package:flutter/material.dart';
import 'package:flutter_application_1/events/firebase_login_signup.dart';
import 'package:flutter_application_1/utils/validate.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class MySignUpPage extends StatefulWidget {
  const MySignUpPage({Key? key}) : super(key: key);
  @override
  State<MySignUpPage> createState() => _MySignUpPageState();
}

class _MySignUpPageState extends State<MySignUpPage> {
  bool value = false;
  // bool _validate = false;
  final _validate = [false, false, false, false];
  final _usernameContrl = TextEditingController();
  final _emailContrl = TextEditingController();
  final _pwdContrl = TextEditingController();
  final _pwdContrl2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        title: const Text('dung phung'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
          ),
        ),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        hintText: 'Enter your username',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        errorText:
                            _validate[0] ? 'Value Can\'t Be Empty' : null,
                      ),
                      controller: _usernameContrl,
                      onSubmitted: (value1) {
                        if (value1.isEmpty) {
                          setState(() {
                            _validate[0] = true;
                          });
                        } else {
                          setState(() {
                            _validate[0] = false;
                          });
                        }
                      },
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        errorText: _validate[1] ? 'Not email format' : null,
                      ),
                      controller: _emailContrl,
                      onSubmitted: (value) {
                        setState(() {
                          _validate[1] = !validateEmail(_emailContrl.text);
                        });
                      },
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        hintText: 'Enter your password',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        errorText: _validate[2] ? 'Not password format' : null,
                      ),
                      controller: _pwdContrl,
                      onChanged: (value) {
                        setState(() {
                          _validate[2] = !validatePassword(value);
                        });
                      },
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          hintText: 'Confirm your password',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          errorText: _validate[3] ? 'Not match password' : null,
                        ),
                        controller: _pwdContrl2,
                        onChanged: (value) => setState(() {
                              _validate[3] = !validateConfirmPassword(
                                  value, _pwdContrl.text);
                            }))),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CheckboxListTile(
              title: const Text(
                'I agree to the terms and conditions',
                style: TextStyle(fontSize: 15),
              ),
              value: value,
              onChanged: (value) {
                setState(() {
                  this.value = value!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ),
          // test
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                final LoginResult result = await FacebookAuth.instance.login();

                if (result.status == LoginStatus.success) {
                  // User is logged in successfully
                  final AccessToken accessToken = result.accessToken!;
                  // Use the accessToken for further operations like fetching user data
                } else if (result.status == LoginStatus.cancelled) {
                  // User cancelled the login process
                  print('cancel');
                } else {
                  // Error occurred during the login process
                  print('error');
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'facebook',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_validate.contains(true) || !value) {
                  return;
                } else {
                  signUpWithEmail(
                      context, _emailContrl, _pwdContrl, value, _validate);
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Sign up',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

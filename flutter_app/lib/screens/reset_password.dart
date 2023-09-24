import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Reset Password",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              MediaQuery.of(context).size.height * 0.15,
              20,
              0,
            ),
            child: Column(
              children: [
                Container(
                  alignment: AlignmentDirectional.bottomStart,
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: const Text('Username'),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0.0, 16, 20),
                  child: Opacity(
                    opacity: 0.5,
                    child: TextField(
                      controller: _emailTextController,
                      decoration: const InputDecoration(
                        labelText: 'Type your username',
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                      "Please type your email we will send you a link to reset your password"),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance
                        .sendPasswordResetEmail(
                            email: _emailTextController.text)
                        .then(
                          (value) => Navigator.of(context).pop(),
                        );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                  ),
                  child: const Center(
                    child: Text(
                      'Update Password',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

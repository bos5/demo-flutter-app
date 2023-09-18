import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/sign_up_page.dart';
import 'firebase_options.dart';

// ...

void main() async {
  runApp(const MyApp());
// ...

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Login Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
          ),
        ),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 100,
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
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter your username',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                        ),
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
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                        ),
                      ),
                    ),
                  ],
                )),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {},
                child: const Text('Forgot password?',
                    style: TextStyle(fontSize: 15, color: Colors.black)),
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                child: Column(
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white,
                          // minimumSize: const Size(400, 40),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Sign in',
                          style: TextStyle(fontSize: 20),
                        ))
                  ],
                )),
            Container(
              padding: const EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              child: Text('Or sign in with',
                  style: TextStyle(fontSize: 15, color: Colors.grey[400])),
            ),
            ButtonTheme(
              child: ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.facebook,
                        size: 40,
                        color: Colors.white70,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.email,
                        size: 40,
                        color: Colors.white70,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.phone,
                        size: 40,
                        color: Colors.white70,
                      )),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              child: Text('Or sign in with',
                  style: TextStyle(fontSize: 15, color: Colors.grey[400])),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpPage()),
                  );
                },
                child: const Text('Sign up',
                    style: TextStyle(fontSize: 15, color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

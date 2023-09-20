import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

ButtonTheme loginOption() {
  return ButtonTheme(
    child: ButtonBar(
      alignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              FacebookAuth.instance.login();
            },
            icon: Icon(
              FontAwesomeIcons.facebook,
              size: 40,
              color: Colors.blue[900],
            )),
        IconButton(
            onPressed: () {
              // FirebaseAuth.instance.;
            },
            icon: Icon(
              FontAwesomeIcons.google,
              size: 40,
              color: Colors.red[900],
            )),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              FontAwesomeIcons.twitter,
              size: 40,
              color: Colors.blue,
            )),
      ],
    ),
  );
}

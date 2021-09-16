import 'dart:async';

import 'package:blog/view/home_page.dart';
import 'package:blog/view/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    super.initState();

    countDownTime();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(child: CircularProgressIndicator()),
      color: Colors.black45,
    );
  }

  Future<void> countDownTime() async {
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushAndRemoveUntil<void>(
            context,
            MaterialPageRoute<void>(
                builder: (BuildContext context) => const SignIn()),
            (Route<dynamic> route) => false);
      } else {
        Navigator.pushAndRemoveUntil<void>(
            context,
            MaterialPageRoute<void>(
                builder: (BuildContext context) => const HomePage()),
            (Route<dynamic> route) => false);
      }
    });
  }
}

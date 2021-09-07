import 'package:blog/provider/app_state_notifier.dart';
import 'package:blog/view/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  String username = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? const CircularProgressIndicator()
        : Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(Icons.arrow_back_ios_new)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: <Widget>[
                            const SizedBox(
                              height: 25,
                            ),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Sign up',
                                  style: TextStyle(
                                      color: Colors.teal,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                )),
                            const SizedBox(height: 15.0),
                            TextFormField(
                              decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 30, 55, 91),
                                        width: 2.0),
                                  ),
                                  prefixIcon:
                                      Icon(Icons.person, color: Colors.grey),
                                  hintText: 'Username',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30)))),
                              validator: (String? val) =>
                                  val!.isEmpty ? 'Enter your Username' : null,
                              onChanged: (String val) {
                                setState(() => username = val);
                              },
                            ),
                            const SizedBox(height: 20.0),
                            TextFormField(
                              decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 30, 55, 91),
                                        width: 2.0),
                                  ),
                                  prefixIcon:
                                      Icon(Icons.email, color: Colors.grey),
                                  hintText: 'Email',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30)))),
                              validator: (String? val) =>
                                  val!.isEmpty ? 'Enter an email' : null,
                              onChanged: (String val) {
                                setState(() => email = val);
                              },
                            ),
                            const SizedBox(height: 20.0),
                            TextFormField(
                              decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 30, 55, 91),
                                        width: 2.0),
                                  ),
                                  prefixIcon: Icon(Icons.lock_outline,
                                      color: Colors.grey),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30)))),
                              obscureText: true,
                              validator: (String? val) => val!.length < 6
                                  ? 'Enter a password 6+ chars long'
                                  : null,
                              onChanged: (String val) {
                                setState(() => password = val);
                              },
                            ),
                            const SizedBox(height: 20.0),
                            MaterialButton(
                                minWidth: 150,
                                height: 40,
                                shape: const StadiumBorder(),
                                color: Colors.teal,
                                child: const Text(
                                  'Sign up',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    // setState(() => loading = true);

                                    try {
                                      context
                                          .read<AppStateNotifier>()
                                          .signUp(username, email, password)
                                          .then((void value) =>
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Registered Successfully'),
                                                ),
                                              ))
                                          .then((void value) => Navigator
                                                  .pushAndRemoveUntil<void>(
                                                context,
                                                MaterialPageRoute<void>(
                                                    builder: (BuildContext
                                                            context) =>
                                                        const Wrapper()),
                                                ModalRoute.withName('/'),
                                              ));
                                    } on FirebaseAuthException catch (e) {
                                      if (e.code == 'weak-password') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'The password provided is too weak'),
                                          ),
                                        );
                                        print(
                                            'The password provided is too weak.');
                                      } else if (e.code ==
                                          'email-already-in-use') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'The account already exists for that email'),
                                          ),
                                        );
                                      }
                                    } catch (e) {
                                      print(e);
                                    }
                                  }
                                }),
                            const SizedBox(
                              height: 5,
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Already have account? Login',
                                  style: TextStyle(color: Colors.black)),
                            ),
                          ],
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

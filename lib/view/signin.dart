import 'package:blog/provider/provider_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  late String firstname;

  late String secondname;

  @override
  Widget build(BuildContext context) {
    return loading
        ? const CircularProgressIndicator()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          child:  Text(
                            'Sign in',
                            style: TextStyle(
                                color:Theme.of(context).backgroundColor,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          )),
                      const SizedBox(height: 15.0),
                      const SizedBox(height: 50.0),
                      TextFormField(
                        decoration:  InputDecoration(
                            enabledBorder:  OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(
                                  color: Theme.of(context).focusColor,
                                  width: 2.0),
                            ),
                            prefixIcon: Icon(Icons.email, color: Theme.of(context).hintColor),
                            hintText: 'Email',
                            
                            hintStyle: TextStyle(color: Theme.of(context).hintColor),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)))),
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return 'Email is Required';
                          }
                          if (!RegExp(
                                  r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$')
                              .hasMatch(val)) {
                            return 'Please enter a valid Email';
                          }
                          return null;
                        },
                        onChanged: (String val) {
                          setState(() => email = val);
                        },
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        decoration:  InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(
                                  color: Theme.of(context).focusColor,
                                  width: 2.0),
                            ),
                            prefixIcon:
                                Icon(Icons.lock_outline, color: Theme.of(context).hintColor),
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Theme.of(context).hintColor),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)))),
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
                          color: Theme.of(context).backgroundColor,
                          child: const Text(
                            'Sign in',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              context.appViewModel
                                  .signIn(email, password, context);

                              FirebaseAuth.instance
                                  .userChanges()
                                  .listen((User? user) {
                                if (user == null) {
                                  print('User is currently signed out!');
                                } else {
                                  context.navigation.submit();
                                }
                              });
                            }
                          }),
                      const SizedBox(
                        height: 5,
                      ),
                      TextButton(
                        onPressed: () => context.navigation.signUp(),
                        child: const Text('Create account? Sign up',
                            style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

 
}

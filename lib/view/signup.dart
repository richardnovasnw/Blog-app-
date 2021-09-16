import 'package:blog/provider/provider_utils.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  String email = '';
  String password = '';

  String username = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? const CircularProgressIndicator()
        : Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              elevation: 0,
              automaticallyImplyLeading: true,
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 25,
                          ),
                          Container(
                              alignment: Alignment.centerLeft,
                              child:  Text(
                                'Sign up',
                                style: TextStyle(
                                    color: Theme.of(context).backgroundColor,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              )),
                          const SizedBox(height: 30.0),
                          TextFormField(
                            decoration:  InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor, width: 2.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(
                                      color: Theme.of(context).focusColor,
                                      width: 2.0),
                                ),
                                prefixIcon:
                                    Icon(Icons.person, color: Theme.of(context).hintColor),
                                hintText: 'Username',
                                hintStyle: TextStyle(color: Theme.of(context).hintColor),
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)))),
                            validator: (String? val) =>
                                val!.isEmpty ? 'Enter your Username' : null,
                            onChanged: (String val) {
                              setState(() => username = val);
                            },
                          ),
                          const SizedBox(height: 20.0),
                          TextFormField(
                            decoration:  InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor, width: 2.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(
                                      color: Theme.of(context).focusColor,
                                      width: 2.0),
                                ),
                                prefixIcon:
                                    Icon(Icons.email, color: Theme.of(context).hintColor),
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
                                  borderSide: BorderSide(
                                      color:Theme.of(context).primaryColor, width: 2.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(
                                      color: Theme.of(context).focusColor,
                                      width: 2.0),
                                ),
                                prefixIcon: Icon(Icons.lock_outline,
                                    color:Theme.of(context).hintColor),
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
                                'Sign up',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  // setState(() => loading = true);

                                  context.appViewModel.signUp(
                                      username, email, password, context);
                                }
                              }),
                          const SizedBox(
                            height: 5,
                          ),
                          TextButton(
                            onPressed: () => context.navigation.signIn(),
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
          );
  }
}

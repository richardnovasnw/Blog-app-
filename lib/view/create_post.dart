import 'package:blog/provider/app_state_notifier.dart';
import 'package:blog/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:blog/provider/provider_utils.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String title;
  late String author;

  late String content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Create Post'),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: .1),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: .1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: .1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: .1),
                      ),
                      hintText: 'Title',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)))),
                  validator: (String? val) =>
                      val!.isEmpty ? 'Enter Title' : null,
                  onChanged: (String val) {
                    setState(() => title = val);
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  minLines: 16,
                  maxLines: 50,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  decoration: const InputDecoration(
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: .1),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: .1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 30, 55, 91), width: .1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 30, 55, 91), width: .1),
                      ),
                      hintText: 'Content',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)))),
                  validator: (String? val) =>
                      val!.isEmpty ? 'Add Content' : null,
                  onChanged: (String val) {
                    setState(() => content = val);
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: .1),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: .1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: .1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: .1),
                      ),
                      hintText: 'Author',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)))),
                  validator: (String? val) =>
                      val!.isEmpty ? 'Enter Author Name' : null,
                  onChanged: (String val) {
                    setState(() => author = val);
                  },
                ),
                MaterialButton(
                    minWidth: 150,
                    height: 40,
                    shape: const StadiumBorder(),
                    color: Colors.teal,
                    child: const Text(
                      'Add Post',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        context.
                            appViewModel
                            .createPost(title, content, author)
                            .then((void value) => Navigator.pushAndRemoveUntil<void>(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        const HomePage(),
                                  ),
                                  ModalRoute.withName('/'),
                                ));
                      }
                    }),
                const SizedBox(
                  height: 27,
                )
              ],
            )),
      ),
    );
  }
}

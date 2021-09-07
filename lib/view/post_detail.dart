import 'dart:async';

import 'package:blog/model/app_state.dart';
import 'package:blog/model/blog.dart';
import 'package:blog/model/blog_user.dart';
import 'package:blog/provider/app_state_notifier.dart';
import 'package:blog/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostDetail extends StatefulWidget {
  PostDetail({
    Key? key,
    required this.post,
  }) : super(key: key);
  Blog post;

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  late String name;
  Timer? timerr;

  @override
  void initState() {
    // timerr = Timer.periodic(
    //     const Duration(seconds: 2),
    //     (Timer t) => context
    //         .read<AppStateNotifier>()
    //         .getComment(widget.post.docId.toString()));

    context.read<AppStateNotifier>().getComment(widget.post.docId.toString());
    context.read<AppStateNotifier>().getUser();

    super.initState();
  }

  @override
  void dispose() {
    timerr?.cancel();
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String comment;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final AppState getComments = context.watch<AppState>();
    final AppState getUser = context.watch<AppState>();
    final BlogUser name = getUser.user[0];

    return WillPopScope(
      onWillPop: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute<bool>(
            builder: (BuildContext context) => const HomePage(),
          ),
          ModalRoute.withName('/'),
        );
        return Future<bool>.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pushAndRemoveUntil<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const HomePage(),
                  ),
                  ModalRoute.withName('/'),
                );
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height / 3,
                      color: Colors.teal,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 2,
                      color: Colors.white,
                    )
                  ],
                ),
                Positioned(
                    top: 13,
                    left: 15,
                    child: Text(
                      widget.post.title.toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 75),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 30),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.post.content.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              widget.post.author.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Comments',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListView.builder(
                            itemCount: getComments.blog.isEmpty
                                ? 0
                                : getComments.blog.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int i) {
                              final Blog user = getComments.blog[i];

                              return ListTile(
                                title: Text(
                                  user.username.toString(),
                                  style: const TextStyle(color: Colors.black),
                                ),
                                subtitle: Text(
                                  user.comment.toString(),
                                  style: const TextStyle(color: Colors.black),
                                ),
                              );
                            }),
                        const SizedBox(
                          height: 50,
                        ),
                        Column(
                          children: <Widget>[
                            Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    controller: controller,
                                    decoration: const InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        hintText: 'Add comment',
                                        hintStyle:
                                            TextStyle(color: Colors.black54),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30)))),
                                    validator: (String? val) =>
                                        val.toString().isEmpty
                                            ? 'Add comment'
                                            : null,
                                    onChanged: (String val) {
                                      setState(() => comment = val);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.teal)
                                ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context
                                          .read<AppStateNotifier>()
                                          .addComment(
                                              comment,
                                              widget.post.uid.toString(),
                                              widget.post.docId.toString(),
                                              name.username.toString())
                                          .then((void value) async =>
                                              controller.clear());
                                    }
                                  },
                                  child: const Text('Comment')),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

import 'dart:async';

import 'package:blog/model/app_state.dart';
import 'package:blog/model/blog.dart';
import 'package:blog/model/blog_user.dart';
import 'package:blog/provider/app_state_notifier.dart';
import 'package:blog/view/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blog/provider/provider_utils.dart';

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
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  late String name;

  late String edit;

  @override
  void initState() {
    context.appViewModel
        .getComment(widget.post.docId.toString())
        .listen((dynamic value) {
      print('Value from controller $value');
    });
    context.appViewModel.getUser();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _editKey = GlobalKey<FormState>();

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

                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.grey.shade300,
                                    child: Text(
                                        user.username
                                            .toString()
                                            .substring(0, 1),
                                        style:
                                            TextStyle(color: Colors.teal[800])),
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .65),
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                const BorderRadius.only(
                                              topRight: Radius.circular(25),
                                              bottomLeft: Radius.circular(25),
                                              bottomRight: Radius.circular(25),
                                            )),
                                        child: ListTile(
                                          title: Text(
                                            user.username.toString(),
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            user.comment.toString(),
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                              child: user.uid == uid
                                                  ? TextButton(
                                                      child: Text(
                                                        'Edit',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors
                                                                .teal[800]),
                                                      ),
                                                      onPressed: () {
                                                        showModalBottomSheet<
                                                                Widget>(
                                                            isScrollControlled:
                                                                true,
                                                            backgroundColor:
                                                                Colors.white
                                                                    .withOpacity(
                                                                        0),
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return Container(
                                                                padding: EdgeInsets.only(
                                                                    bottom: MediaQuery.of(
                                                                            context)
                                                                        .viewInsets
                                                                        .bottom),
                                                                child: Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Expanded(
                                                                      child:
                                                                          Form(
                                                                        key:
                                                                            _editKey,
                                                                        child:
                                                                            TextFormField(
                                                                          autofocus:
                                                                              true,
                                                                          controller:
                                                                              controller,
                                                                          decoration: const InputDecoration(
                                                                              fillColor: Colors.white,
                                                                              filled: true,
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: Colors.white,
                                                                                ),
                                                                              ),
                                                                              focusedBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: Colors.white,
                                                                                ),
                                                                              ),
                                                                              hintText: 'Edit comment',
                                                                              hintStyle: TextStyle(color: Colors.black54),
                                                                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)))),
                                                                          validator: (String? val) => val.toString().isEmpty
                                                                              ? 'Add comment'
                                                                              : null,
                                                                          onChanged:
                                                                              (String val) {
                                                                            setState(() =>
                                                                                edit = val);
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    IconButton(
                                                                      icon:
                                                                          const Icon(
                                                                        Icons
                                                                            .send,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        if (_editKey
                                                                            .currentState!
                                                                            .validate()) {
                                                                          context
                                                                              .appViewModel
                                                                              .updateComment(edit, user.commentId.toString(), widget.post.docId.toString(), name.username.toString())
                                                                              .then((void value) async => controller.clear())
                                                                              .then((value) => context.appViewModel.getComment(widget.post.docId.toString()).listen((dynamic value) {
                                                                                    print('Value from controller $value');
                                                                                  }));
                                                                        }
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            });
                                                      })
                                                  : const Text('')),
                                          Text(
                                            user.datetime!.toLocal().toString(),
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.teal[800]),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
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
                                    autofocus: false,
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
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.teal)),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.appViewModel
                                          .addComment(
                                              comment,
                                              widget.post.uid.toString(),
                                              widget.post.docId.toString(),
                                              name.username.toString())
                                          .then((void value) async =>
                                              controller.clear())
                                          .then((value) => context.appViewModel
                                                  .getComment(widget.post.docId
                                                      .toString())
                                                  .listen((dynamic value) {
                                                print(
                                                    'Value from controller $value');
                                              }));
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

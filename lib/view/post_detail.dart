import 'dart:async';

import 'package:blog/model/app_state.dart';
import 'package:blog/model/blog.dart';
import 'package:blog/model/blog_user.dart';
import 'package:blog/provider/provider_utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostDetail extends StatefulWidget {
  const PostDetail({
    Key? key,
    required this.post,
  }) : super(key: key);
  final Blog post;

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  late String name;

  late String edit;

  late String replyComment;
  @override
  void initState() {
    context.appViewModel.getComment(widget.post.docId.toString());
    context.appViewModel.getReplyComment(widget.post.docId.toString());

    context.appViewModel.getUser();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _editKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _replyKey = GlobalKey<FormState>();

  late String comment;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AppState getComments = context.appState;
    final AppState getUser = context.appState;
    final BlogUser name = getUser.user[0];

    return getComments.blog.isEmpty 
        ? const Center(child:  CircularProgressIndicator())
        :  Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          elevation: 0,
          // automaticallyImplyLeading: true,
          // foregroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              context.appViewModel
                  .getPost()
                  .then((void value) async => context.navigation.home());
            },
          ),
        ),
        body: WillPopScope(
          onWillPop: () {
            context.appViewModel.getPost();
            return Future<bool>.value(true);
          },
          child: SingleChildScrollView(
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
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 30,
                        ),
                        if (widget.post.image != null)
                          CarouselSlider(
                            options: CarouselOptions(
                              enlargeCenterPage: false,
                              autoPlay: true,
                              aspectRatio: 15 / 9,
                              autoPlayCurve: Curves.easeInToLinear,
                              enableInfiniteScroll: true,
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              autoPlayInterval: const Duration(seconds: 3),
                              viewportFraction: 0.85,
                            ),
                            items: widget.post.image!.map((String item) {
                              return Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(item)),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              );
                            }).toList(),
                          )
                        else
                          const Text('No Images'),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 30),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
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
                                      ? getComments.blog.length
                                      : getComments.blog.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, int i) {
                                    final Blog user = getComments.blog[i];
                                    final DateTime time = DateTime.parse(
                                        user.datetime.toString());
                                    return Column(
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            CircleAvatar(
                                              backgroundColor:
                                                  Colors.grey.shade300,
                                              child: Text(
                                                  user.username
                                                      .toString()
                                                      .substring(0, 1),
                                                  style: TextStyle(
                                                      color: Colors.teal[800])),
                                            ),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  constraints: BoxConstraints(
                                                      maxWidth:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .65),
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade200,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topRight:
                                                            Radius.circular(25),
                                                        bottomLeft:
                                                            Radius.circular(25),
                                                        bottomRight:
                                                            Radius.circular(25),
                                                      )),
                                                  child: ListTile(
                                                    title: Text(
                                                      user.username.toString(),
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    subtitle: Text(
                                                      user.comment.toString(),
                                                      style: const TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Container(
                                                        child: user.uid == uid
                                                            ? TextButton(
                                                                child: Text(
                                                                  'Edit',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                              .teal[
                                                                          800]),
                                                                ),
                                                                onPressed: () {
                                                                  showModalBottomSheet<
                                                                          Widget>(
                                                                      isScrollControlled:
                                                                          true,
                                                                      backgroundColor: Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              0),
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return Container(
                                                                          padding:
                                                                              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                          child:
                                                                              Row(
                                                                            children: <Widget>[
                                                                              Expanded(
                                                                                child: Form(
                                                                                  key: _editKey,
                                                                                  child: TextFormField(
                                                                                    autofocus: true,
                                                                                    controller: controller,
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
                                                                                    validator: (String? val) => val.toString().isEmpty ? 'Add comment' : null,
                                                                                    onChanged: (String val) {
                                                                                      setState(() => edit = val);
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              IconButton(
                                                                                icon: const Icon(
                                                                                  Icons.send,
                                                                                  color: Colors.white,
                                                                                ),
                                                                                onPressed: () {
                                                                                  if (_editKey.currentState!.validate()) {
                                                                                    context.appViewModel.updateComment(edit, user.commentId.toString(), widget.post.docId.toString(), name.username.toString()).then((void value) async => controller.clear()).then((void value) => context.appViewModel.getComment(widget.post.docId.toString()));
                                                                                    Navigator.pop(context);
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
                                                      timeago.format(time),
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              Colors.teal[800]),
                                                    ),
                                                    TextButton(
                                                        child: Text(
                                                          'Reply',
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
                                                                final TextEditingController
                                                                    crController =
                                                                    TextEditingController(
                                                                        text: user
                                                                            .username);

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
                                                                              _replyKey,
                                                                          child:
                                                                              TextFormField(
                                                                            autofocus:
                                                                                true,
                                                                            controller:
                                                                                crController,
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
                                                                                hintText: 'Reply',
                                                                                hintStyle: TextStyle(color: Colors.black54),
                                                                                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)))),
                                                                            validator: (String? val) => val.toString().isEmpty
                                                                                ? 'Reply'
                                                                                : null,
                                                                            onChanged:
                                                                                (String val) {
                                                                              setState(() => replyComment = val);
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      IconButton(
                                                                        icon:
                                                                            const Icon(
                                                                          Icons
                                                                              .send,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          if (_replyKey
                                                                              .currentState!
                                                                              .validate()) {
                                                                            context.appViewModel.replyComment(replyComment, user.uid.toString(), widget.post.docId.toString(), user.commentId.toString(), name.username.toString()).then((void value) async => controller.clear()).then((void value) => context.appViewModel.getComment(widget.post.docId.toString())).then((void value) async =>
                                                                                crController.clear());
                                                                            Navigator.pop(context);
                                                                          }
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              });
                                                        })
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: user.reply == null
                                                ? 0
                                                : user.reply?.asMap().length,
                                            shrinkWrap: true,
                                            itemBuilder:
                                                (BuildContext context, int i) {
                                              final DateTime rtime =
                                                  DateTime.parse(user
                                                      .reply![i].datetime
                                                      .toString());
                                              print(user.reply == null
                                                  ? 0
                                                  : user.reply?.asMap().length);
                                              return user.reply != null
                                                  ? Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        CircleAvatar(
                                                          backgroundColor:
                                                              Colors.grey
                                                                  .shade100,
                                                          child: Text(
                                                              user.reply![i]
                                                                  .username
                                                                  .toString()
                                                                  .substring(
                                                                      0, 1),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                          .teal[
                                                                      800])),
                                                        ),
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                        Column(
                                                          children: <Widget>[
                                                            Container(
                                                              constraints: BoxConstraints(
                                                                  maxWidth: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      .5),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(1),
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade100,
                                                                      borderRadius:
                                                                          const BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(25),
                                                                        bottomLeft:
                                                                            Radius.circular(25),
                                                                        bottomRight:
                                                                            Radius.circular(25),
                                                                      )),
                                                              child: ListTile(
                                                                title: Text(
                                                                  user.reply![i]
                                                                      .username
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                subtitle: Text(
                                                                  user.reply![i]
                                                                      .replyComment
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ),
                                                            ),
                                                            Row(
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  timeago.format(
                                                                      rtime),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                              .teal[
                                                                          800]),
                                                                ),
                                                                TextButton(
                                                                    child: Text(
                                                                      'Reply',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              Colors.teal[800]),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      showModalBottomSheet<
                                                                              Widget>(
                                                                          isScrollControlled:
                                                                              true,
                                                                          backgroundColor: Colors.white.withOpacity(
                                                                              0),
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (BuildContext context) {
                                                                            final TextEditingController
                                                                                _controller =
                                                                                TextEditingController(text: user.reply![i].username);

                                                                            return Container(
                                                                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                              child: Row(
                                                                                children: <Widget>[
                                                                                  Expanded(
                                                                                    child: Form(
                                                                                      key: _replyKey,
                                                                                      child: TextFormField(
                                                                                        autofocus: true,
                                                                                        controller: _controller,
                                                                                        decoration: const InputDecoration(
                                                                                            prefixStyle: TextStyle(color: Colors.black),
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
                                                                                            hintText: 'Reply',
                                                                                            hintStyle: TextStyle(color: Colors.black54),
                                                                                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)))),
                                                                                        validator: (String? val) => val.toString().isEmpty ? 'Reply' : null,
                                                                                        onChanged: (String val) {
                                                                                          setState(() => replyComment = val);
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  IconButton(
                                                                                    icon: const Icon(
                                                                                      Icons.send,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                    onPressed: () {
                                                                                      if (_replyKey.currentState!.validate()) {
                                                                                        context.appViewModel.replyComment(replyComment, user.uid.toString(), widget.post.docId.toString(), user.commentId.toString(), name.username.toString()).then((void value) async => _controller.clear()).then((void value) => context.appViewModel.getComment(widget.post.docId.toString())).then((void value) => _controller.clear());
                                                                                        Navigator.pop(context);
                                                                                      }
                                                                                    },
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          });
                                                                    }),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  : const Text('');
                                            }),
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
                                              hintStyle: TextStyle(
                                                  color: Colors.black54),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              30)))),
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
                                          if (_formKey.currentState!
                                              .validate()) {
                                            context.appViewModel
                                                .addComment(
                                                    comment,
                                                    widget.post.uid.toString(),
                                                    widget.post.docId
                                                        .toString(),
                                                    name.username.toString())
                                                .then((void value) async =>
                                                    controller.clear())
                                                .then((void value) => context
                                                    .appViewModel
                                                    .getComment(widget
                                                        .post.docId
                                                        .toString()));
                                          }
                                        },
                                        child: const Text('Comment')),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

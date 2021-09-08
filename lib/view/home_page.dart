import 'dart:async';

import 'package:blog/model/app_state.dart';
import 'package:blog/model/blog.dart';
import 'package:blog/provider/app_state_notifier.dart';
import 'package:blog/view/create_post.dart';
import 'package:blog/view/post_detail.dart';
import 'package:blog/view/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blog/provider/provider_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Blog id;

  @override
  void initState() {
    context.appViewModel.getPost().listen((dynamic value) {
      print('Value from controller $value');
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // StreamController<String> controller = StreamController<String>();
  // late StreamSubscription<dynamic> streamSubscription;
  @override
  Widget build(BuildContext context) {
    final AppState state = context.watch<AppState>();
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push<void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const CreatePost(),
            ),
          );
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              'Blog',
              style: TextStyle(color: Colors.teal),
            ),
            TextButton(
                onPressed: () {
                  context.appViewModel.signOut().then((void value) =>
                      Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const Wrapper())));
                },
                child: const Text(
                  'Sign out',
                  style: TextStyle(color: Colors.teal),
                ))
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ElevatedButton(
            //     onPressed: () {
            //       context.appViewModel.getPost().listen((dynamic value) {
            //         print('Value from controller $value');
            //       });
            //     },
            //     child: const Text('Stream')),
            // ElevatedButton(
            //     onPressed: () {
            //       Stream stream = controller.stream;
            //       controller.add('12');
            //     },
            //     child: Text('emit')),
            // ElevatedButton(
            //     onPressed: () {
            //       streamSubscription.cancel();
            //     },
            //     child: Text('unsubcribe')),
            ListView.builder(
                itemCount: state.blog.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int i) {
                  final Blog post = state.blog[i];
                  return post.title == null
                      ? const Text('')
                      : GestureDetector(
                          onTap: () {
                            Navigator.push<void>(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      PostDetail(post: post),
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  image: const DecorationImage(
                                      image: NetworkImage(
                                        'https://st2.depositphotos.com/1077310/5839/i/950/depositphotos_58394193-stock-photo-teal-background.jpg',
                                      ),
                                      fit: BoxFit.fill)),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                color: Colors.transparent,
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      subtitle: Text(
                                        'by ${post.author.toString()}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      title: Text(
                                        post.title.toString(),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 25),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(post.content.toString(),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ))),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        TextButton.icon(
                                            onPressed: () {
                                              context.appViewModel
                                                  .like(post.docId.toString())
                                                  .then((value) => context
                                                          .appViewModel
                                                          .getPost()
                                                          .listen(
                                                              (dynamic value) {
                                                        print(
                                                            'Value from controller $value');
                                                      }));
                                            },
                                            icon: Icon(
                                              Icons.favorite,
                                              color: post.like
                                                          .toString()
                                                          .contains(FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid) ==
                                                      true
                                                  ? Colors.red
                                                  : Colors.grey,
                                            ),
                                            label: Text('${post.like?.length}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                )))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                }),
          ],
        ),
      ),
    );
  }
}

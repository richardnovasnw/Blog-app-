import 'package:blog/model/app_state.dart';
import 'package:blog/model/blog.dart';
import 'package:blog/provider/provider_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Blog id;

  @override
  void initState() {
    context.appViewModel.getPost();

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
    return state.blog.isEmpty
        ? const Center(child:  CircularProgressIndicator())
        : Scaffold(
            backgroundColor: Colors.white,
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.teal,
              child: const Icon(Icons.add),
              onPressed: () {
                context.navigation.createPost();
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
                        context.appViewModel
                            .signOut()
                            .then((void value) => context.navigation.signIn());
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
                children: <Widget>[
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
                  Container(
                    child: state.blog[0].title == null
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount:
                                state.blog.isEmpty ? 0 : state.blog.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int i) {
                              final Blog post = state.blog[i];
                              return GestureDetector(
                                onTap: () {
                                  context.navigation.viewPost(post: post);
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
                                          borderRadius:
                                              BorderRadius.circular(20)),
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
                                                  color: Colors.white,
                                                  fontSize: 25),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(18.0),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                    post.content.toString(),
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                    ))),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              TextButton.icon(
                                                  onPressed: () {
                                                    context.appViewModel
                                                        .like(post.docId
                                                            .toString())
                                                        .then((void value) =>
                                                            context.appViewModel
                                                                .getPost());
                                                  },
                                                  icon: Icon(
                                                    Icons.favorite,
                                                    color: post.like
                                                                .toString()
                                                                .contains(
                                                                    FirebaseAuth
                                                                        .instance
                                                                        .currentUser!
                                                                        .uid) ==
                                                            true
                                                        ? Colors.red
                                                        : Colors.grey,
                                                  ),
                                                  label: Text(
                                                      '${post.like?.length}',
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
                  ),
                ],
              ),
            ),
          );
  }
}

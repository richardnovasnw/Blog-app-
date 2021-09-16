import 'package:blog/core/navigation/navigation.dart';
import 'package:blog/model/blog.dart';
import 'package:blog/view/create_post.dart';
import 'package:blog/view/home_page.dart';
import 'package:blog/view/navigation/app_navigation_state.dart';
import 'package:blog/view/post_detail.dart';
import 'package:blog/view/signin.dart';
import 'package:blog/view/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppNavigationController extends AppFlowController<AppNavigationState> {
  AppNavigationController() : super(AppNavigationState());
  late Blog l;
  // ignore: unused_element
  void _setState(AppNavigationState state) => this.state = state;

  void init() {
    print('Initializing...');
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        state = state.rebuild((AppNavigationStateBuilder b) => b.value = null);
      } else {
        state = state.rebuild((AppNavigationStateBuilder b) =>
            b.value = FirebaseAuth.instance.currentUser?.uid);
      }
    });
  }

  void signIn() {
    state = state.rebuild((AppNavigationStateBuilder b) => b.value = null);
  }

  void submit() {
    state = state.rebuild((AppNavigationStateBuilder b) =>
        b.value = FirebaseAuth.instance.currentUser?.uid);
  }

  void signUp() {
    state = state.rebuild((AppNavigationStateBuilder b) => b.value = 'signup');
  }

  void createPost() {
    state =
        state.rebuild((AppNavigationStateBuilder b) => b.create = 'createPost');
  }

  void viewPost({required Blog post}) {
    l = post;
    state =
        state.rebuild((AppNavigationStateBuilder b) => b.create = 'viewPost');
  }

  void home() {
    state = state.rebuild((AppNavigationStateBuilder b) => b.create = 'in');
  }

  @override
  List<Page<Object>> onGeneratePages(
    AppNavigationState state,
    List<Page<Object>> currentPages,
  ) {
    return <Page<Object>>[
      //Auth
      if (state.value == null)
        const MaterialPage<Object>(
          child: SignIn(),
        )
      else
        (state.value == FirebaseAuth.instance.currentUser?.uid)
            ? const MaterialPage<Object>(
                child: HomePage(),
              )
            : (state.value == 'signup')
                ? const MaterialPage<Object>(child: SignUp())
                : const MaterialPage<Object>(
                    child: SignIn(),
                  ),

      if (state.create == 'createPost')
        const MaterialPage<Object>(
          child: CreatePost(),
        )
      else if (state.create == 'viewPost')
        MaterialPage<Object>(
            child: PostDetail(
          post: l,
        ))

      // if (state.create == 'in')
      //   const MaterialPage<Object>(
      //     child: HomePage(),
      //   )
      // else
      //   (state.create == 'createPost')
      //       ? const MaterialPage<Object>(
      //           child: CreatePost(),
      //         )
      //       : (state.create == 'viewPost')
      //           ? MaterialPage<Object>(
      //               child: PostDetail(
      //               post: l,
      //             ))
      //           : const MaterialPage<Object>(
      //               child: SignIn(),
      //             ),
    ];
  }
}

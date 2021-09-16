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
        state = state.rebuild((AppNavigationStateBuilder b) => b.initialRoute = null);
      } else {
        state = state.rebuild((AppNavigationStateBuilder b) =>
            b.initialRoute = InitialRoute.home);
      }
    });
  }

  void signIn() {
    state = state.rebuild((AppNavigationStateBuilder b) => b.initialRoute = null);
  }

  void submit() {
    state = state.rebuild((AppNavigationStateBuilder b) =>
        b.initialRoute = InitialRoute.home);
  }

  void signUp() {
    state = state.rebuild((AppNavigationStateBuilder b) => b.initialRoute = InitialRoute.signUp);
  }

  void createPost() {
    state =
        state.rebuild((AppNavigationStateBuilder b) => b.homeRoute = HomeRoute.createPost);
  }

  void viewPost({required Blog post}) {
    l = post;
    state =
        state.rebuild((AppNavigationStateBuilder b) => b.homeRoute = HomeRoute.viewPost);
  }

  void home() {
    state = state.rebuild((AppNavigationStateBuilder b) => b.homeRoute = HomeRoute.home);
  }

  @override
  List<Page<Object>> onGeneratePages(
    AppNavigationState state,
    List<Page<Object>> currentPages,
  ) {
    return <Page<Object>>[
      //Auth
      if (state.initialRoute == null)
        const MaterialPage<Object>(
          child: SignIn(),
        )
      else
        (state.initialRoute == InitialRoute.home)
            ? const MaterialPage<Object>(
                child: HomePage(),
              )
            : (state.initialRoute == InitialRoute.signUp)
                ? const MaterialPage<Object>(child: SignUp())
                : const MaterialPage<Object>(
                    child: SignIn(),
                  ),

      if (state.homeRoute == HomeRoute.createPost)
        const MaterialPage<Object>(
          child: CreatePost(),
        )
      else if (state.homeRoute == HomeRoute.viewPost)
        MaterialPage<Object>(
            child: PostDetail(
          post: l,
        ))

     
    ];
  }
}
enum InitialRoute {
  signIn,
  signUp,
  home
}

enum HomeRoute {
  viewPost,
  createPost,
  home
}
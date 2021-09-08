import 'package:blog/data/firebase_service.dart';
import 'package:blog/model/blog.dart';
import 'package:blog/model/blog_user.dart';
import 'package:built_collection/built_collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:blog/core/view_model/view_model.dart';
import 'package:blog/model/app_state.dart';
import 'package:blog/provider/app_state_notifier.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return StateNotifierProvider<AppViewModel, AppState>(
      create: (_) => AppViewModel(),
      child: child,
    );
  }
}

class AppViewModel extends AppStateNotifier<AppState>
    with LocatorMixin
    implements AppBaseViewModel {
  AppViewModel() : super(AppState());

  @override
  Future<void> init() async {}


  Future<void> like(String docId) async {
    FirebaseService().like(docId);
  }

  Future<void> getLike(String docId) async {
    final BuiltList<Blog> n = await FirebaseService().getLike(docId);
    state = state.rebuild((AppStateBuilder b) => b..blog = n.toBuilder());
  }

  Future<void> createPost(String title, String content, String author) async {
    FirebaseService().createPost(title, content, author);
  }

  Stream<void> getPost() async* {
    final BuiltList<Blog> n = await FirebaseService().getPost();
    state = state.rebuild((AppStateBuilder b) => b..blog = n.toBuilder());
  }

  Future<void> getUser() async {
    final BuiltList<BlogUser> n = await FirebaseService().getUser();
    state = state.rebuild((AppStateBuilder b) => b..user = n.toBuilder());
  }

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    FirebaseService().signIn(email, password, context);
  }

  Future<void> signUp(String username, String email, String password,BuildContext context) async {
    FirebaseService().signUp(username, email, password, context);
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> addComment(
      String comment, String uid, String docId, String username) async {
    FirebaseService().addComment(comment, uid, docId, username);
  }

  Future<void> updateComment(
      String comment, String commentId, String docId, String username) async {
    FirebaseService().updateComment(comment, commentId, docId, username);
  }

  Stream<void> getComment(String docId) async* {
    final BuiltList<Blog> n = await FirebaseService().getComment(docId);
    state = state.rebuild((AppStateBuilder b) => b..blog = n.toBuilder());
  }


}
























import 'package:blog/data/firebase_service.dart';
import 'package:blog/model/app_state.dart';
import 'package:blog/model/blog.dart';
import 'package:blog/model/blog_user.dart';
import 'package:built_collection/built_collection.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:state_notifier/state_notifier.dart';

class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier() : super(AppState());
  void init() {
    print('initializing');
  }

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

  Future<void> getPost() async {
    final BuiltList<Blog> n = await FirebaseService().getPost();
    state = state.rebuild((AppStateBuilder b) => b..blog = n.toBuilder());
  }

  Future<void> getUser() async {
    final BuiltList<BlogUser> n = await FirebaseService().getUser();
    state = state.rebuild((AppStateBuilder b) => b..user = n.toBuilder());
  }

  Future<void> signIn(String email, String password) async {
    FirebaseService().signIn(email, password);
  }

  Future<void> signUp(String username, String email, String password) async {
    FirebaseService().signUp(username, email, password);
    
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> addComment(
      String comment, String uid, String docId, String username) async {
    FirebaseService().addComment(comment, uid, docId, username);
  }

  Future<void> getComment(String docId) async {
    final BuiltList<Blog> n = await FirebaseService().getComment(docId);
    state = state.rebuild((AppStateBuilder b) => b..blog = n.toBuilder());
  }

  
}

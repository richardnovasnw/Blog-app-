import 'package:blog/core/services/blog_service.dart';
import 'package:blog/model/blog.dart';
import 'package:blog/model/blog_user.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FirebaseService implements BlogService {
  @override
  Future<void> dispose() async {}

  @override
  Future<void> init() async {}

  @override
  Future<void> signUp(String username, String email, String password,
      BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((UserCredential value) {
        final DocumentReference<Map<String, dynamic>> ref =
            FirebaseFirestore.instance.collection('register').doc();
        ref.set(<String, dynamic>{
          'datetime': FieldValue.serverTimestamp(),
          'username': username,
          'uid': FirebaseAuth.instance.currentUser!.uid,
        });
      }).then((value) {
        if (FirebaseAuth.instance.userChanges() != null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Sucessfully Registered')));
        }
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.code)));

      print('Failed with error code: ${e.code}');
      print(e.message);
    }
  }

  @override
  Future<void> signIn(
      String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.code)));

      print('Failed with error code: ${e.code}');
      print(e.message);
    }
  }

  @override
  Future<void> createPost(String title, String content, String author) async {
    final DocumentReference<Map<String, dynamic>> ref =
        FirebaseFirestore.instance.collection('posts').doc();
    ref.set(<String, dynamic>{
      'title': title,
      'content': content,
      'author': author,
      'datetime': DateTime.now().toLocal(),
      'docId': ref.id,
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'like': FieldValue.arrayUnion(<String>[])
    }).whenComplete(() {
      final DocumentReference<Map<String, dynamic>> reff = FirebaseFirestore
          .instance
          .collection('posts')
          .doc(ref.id)
          .collection('comments')
          .doc(ref.id);
      reff.set(<String, dynamic>{});
    });
  }

  @override
  Future<BuiltList<Blog>> getPost() async {
    final Query<Map<String, dynamic>> _collectionRef = FirebaseFirestore
        .instance
        .collection('posts')
        .orderBy('datetime', descending: true);
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _collectionRef.get();

    final List<Map<String, dynamic>> allData = querySnapshot.docs
        .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) => doc.data())
        .toList();

    print(allData);
    final List<Map<String, dynamic>> results = allData;
    final List<Blog> list = <Blog>[];

    try {
      for (int i = 0; i < results.length; i++) {
        final Map<String, dynamic> d = results[i];

        list.add(Blog.fromJson(d)!);
      }
    } on Exception catch (e) {
      print(e);
    } catch (error, s) {
      print(error);
      print(s);
    }
    print(list);
    return list.toBuiltList();
  }

  @override
  Future<void> addComment(
      String comment, String uid, String docId, String username) async {
    final DocumentReference<Map<String, dynamic>> ref = FirebaseFirestore
        .instance
        .collection('posts')
        .doc(docId)
        .collection('comments')
        .doc();
    ref.set(<String, dynamic>{
      'comment': comment,
      'username': username,
      'commentId': ref.id,
      'docId': docId,
      'datetime': DateTime.now().toLocal(),
      'uid': FirebaseAuth.instance.currentUser!.uid,
    });
  }

  @override
  Future<void> updateComment(
      String comment, String commentId, String docId, String username) async {
    print(commentId);
    final DocumentReference<Map<String, dynamic>> ref = FirebaseFirestore
        .instance
        .collection('posts')
        .doc(docId)
        .collection('comments')
        .doc(commentId);
    ref.update(<String, dynamic>{
      'comment': comment,
      'datetime': DateTime.now().toLocal(),
    });
  }

  @override
  Future<BuiltList<Blog>> getComment(String docId) async {
    final Query<Map<String, dynamic>> _collectionRef = FirebaseFirestore
        .instance
        .collection('posts')
        .doc(docId)
        .collection('comments')
        .orderBy('datetime', descending: true)
        .where('docId', isEqualTo: docId);

    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _collectionRef.get();

    final List<Map<String, dynamic>> allData = querySnapshot.docs
        .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) => doc.data())
        .toList();

    print(allData);
    final List<Map<String, dynamic>> results = allData;
    final List<Blog> list = <Blog>[];

    try {
      for (int i = 0; i < results.length; i++) {
        final Map<String, dynamic> d = results[i];

        list.add(Blog.fromJson(d)!);
      }
    } on Exception catch (e) {
      print(e);
    } catch (error, s) {
      print(error);
      print(s);
    }
    print(list);
    return list.toBuiltList();
  }

  @override
  Future<BuiltList<BlogUser>> getUser() async {
    final String id = FirebaseAuth.instance.currentUser!.uid;
    final Query<Map<String, dynamic>> _collectionRef = FirebaseFirestore
        .instance
        .collection('register')
        .where('uid', isEqualTo: id);

    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _collectionRef.get();

    final List<Map<String, dynamic>> allData = querySnapshot.docs
        .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) => doc.data())
        .toList();

    print('$allData');
    final List<Map<String, dynamic>> results = allData;
    final List<BlogUser> list = <BlogUser>[];

    try {
      for (int i = 0; i < results.length; i++) {
        final Map<String, dynamic> d = results[i];

        list.add(BlogUser.fromJson(d)!);
      }
    } on Exception catch (e) {
      print(e);
    } catch (error, s) {
      print(error);
      print(s);
    }
    print(list.elementAt(0));
    return list.toBuiltList();
  }

  @override
  Future<BuiltList<Blog>> getLike(String docId) async {
    final Query<Map<String, dynamic>> _collectionRef = FirebaseFirestore
        .instance
        .collection('posts')
        .doc(docId)
        .collection('like')
        .where('docId', isEqualTo: docId);

    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _collectionRef.get();

    final List<Map<String, dynamic>> allData = querySnapshot.docs
        .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) => doc.data())
        .toList();

    print(allData);
    final List<Map<String, dynamic>> results = allData;
    final List<Blog> list = <Blog>[];

    try {
      for (int i = 0; i < results.length; i++) {
        final Map<String, dynamic> d = results[i];

        list.add(Blog.fromJson(d)!);
      }
    } on Exception catch (e) {
      print(e);
    } catch (error, s) {
      print(error);
      print(s);
    }
    print(list);
    return list.toBuiltList();
  }

  @override
  Future<void> like(String docId) async {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(docId)
        .set(<String, dynamic>{
      'like': FieldValue.arrayUnion(
          <String>[FirebaseAuth.instance.currentUser!.uid])
    }, SetOptions(merge: true));
  }
}

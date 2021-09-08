library blog;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:blog/model/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'blog.g.dart';

abstract class Blog implements Built<Blog, BlogBuilder> {
  factory Blog([Function(BlogBuilder b) updates]) = _$Blog;
  Blog._();
  String toJson() {
    return json.encode(serializers.serializeWith(Blog.serializer, this));
  }

  static Blog? fromJson(Map<String, dynamic> jsonString) {
    return serializers.deserializeWith(Blog.serializer, jsonString);
  }

  String? get title;
  String? get content;
  String? get author;
  String? get docId;
  String? get username;
  String? get comment;
  String? get uid;
  String? get commentId;
  DateTime? get datetime;
  BuiltList<String>? get like;

  static Serializer<Blog> get serializer => _$blogSerializer;
}

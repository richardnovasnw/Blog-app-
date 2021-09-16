library blog_user;

import 'dart:convert';

import 'package:blog/model/serializer.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
part 'blog_user.g.dart';

abstract class BlogUser implements Built<BlogUser, BlogUserBuilder> {
  factory BlogUser([Function(BlogUserBuilder b) updates]) = _$BlogUser;
  BlogUser._();
  String toJson() {
    return json.encode(serializers.serializeWith(BlogUser.serializer, this));
  }

  static BlogUser? fromJson(Map<String, dynamic> jsonString) {
    return serializers.deserializeWith(BlogUser.serializer, jsonString);
  }

  String? get username;
 

  static Serializer<BlogUser> get serializer => _$blogUserSerializer;
}

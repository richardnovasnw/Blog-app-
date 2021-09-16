library reply_details;

import 'dart:convert';

import 'package:blog/model/serializer.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'reply_details.g.dart';

abstract class ReplyDetails
    implements Built<ReplyDetails, ReplyDetailsBuilder> {
  factory ReplyDetails([Function(ReplyDetailsBuilder b) updates]) =
      _$ReplyDetails;
  ReplyDetails._();
  String toJson() {
    return json
        .encode(serializers.serializeWith(ReplyDetails.serializer, this));
  }

  static ReplyDetails? fromJson(Map<String, dynamic> jsonString) {
    return serializers.deserializeWith(ReplyDetails.serializer, jsonString);
  }

  String? get username;

  String? get replyComment;

  DateTime? get datetime;

  static Serializer<ReplyDetails> get serializer => _$replyDetailsSerializer;
}

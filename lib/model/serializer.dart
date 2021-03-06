library serializer;

import 'package:blog/model/app_state.dart';
import 'package:blog/model/blog.dart';
import 'package:blog/model/blog_user.dart';
import 'package:blog/model/datetime.dart';
import 'package:blog/model/reply_details.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

part 'serializer.g.dart';

@SerializersFor(<Type>[AppState, Blog, ReplyDetails])
final Serializers serializers = (_$serializers.toBuilder()
      ..add(DateTimeSerializer())
      ..addPlugin(StandardJsonPlugin()))
    .build();

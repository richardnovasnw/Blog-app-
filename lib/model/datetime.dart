import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DateTimeSerializer implements PrimitiveSerializer<DateTime> {
  final bool structured = false;
  @override
  final Iterable<Type> types = BuiltList<Type>(<Type>[DateTime]);
  @override
  final String wireName = 'DateTime';

  @override
  Object serialize(
    Serializers serializers,
    DateTime dateTime, {
    FullType specifiedType = FullType.unspecified,
  }) {
    if (!dateTime.isUtc) {
      throw ArgumentError.value(
          dateTime, 'dateTime', 'Must be in utc for serialization.');
    }
    return Timestamp.fromDate(dateTime);
  }

  @override
  DateTime deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    DateTime? date;
    if (serialized is List) {
      return DateTime.now();
    }
    if (serialized is int) {
      date = DateTime.fromMicrosecondsSinceEpoch(serialized);
    }
    if (serialized is Timestamp) {
      date = DateTime.fromMicrosecondsSinceEpoch(
        serialized.microsecondsSinceEpoch,
      );
    }
    if (date == null) {
      throw 'Date cannot be null';
    }
    return date;
  }
}
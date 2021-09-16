// GENERATED CODE - DO NOT MODIFY BY HAND

part of reply_details;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ReplyDetails> _$replyDetailsSerializer =
    new _$ReplyDetailsSerializer();

class _$ReplyDetailsSerializer implements StructuredSerializer<ReplyDetails> {
  @override
  final Iterable<Type> types = const [ReplyDetails, _$ReplyDetails];
  @override
  final String wireName = 'ReplyDetails';

  @override
  Iterable<Object?> serialize(Serializers serializers, ReplyDetails object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.username;
    if (value != null) {
      result
        ..add('username')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.replyComment;
    if (value != null) {
      result
        ..add('replyComment')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.datetime;
    if (value != null) {
      result
        ..add('datetime')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    return result;
  }

  @override
  ReplyDetails deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ReplyDetailsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'replyComment':
          result.replyComment = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'datetime':
          result.datetime = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
      }
    }

    return result.build();
  }
}

class _$ReplyDetails extends ReplyDetails {
  @override
  final String? username;
  @override
  final String? replyComment;
  @override
  final DateTime? datetime;

  factory _$ReplyDetails([void Function(ReplyDetailsBuilder)? updates]) =>
      (new ReplyDetailsBuilder()..update(updates)).build();

  _$ReplyDetails._({this.username, this.replyComment, this.datetime})
      : super._();

  @override
  ReplyDetails rebuild(void Function(ReplyDetailsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReplyDetailsBuilder toBuilder() => new ReplyDetailsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReplyDetails &&
        username == other.username &&
        replyComment == other.replyComment &&
        datetime == other.datetime;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, username.hashCode), replyComment.hashCode),
        datetime.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ReplyDetails')
          ..add('username', username)
          ..add('replyComment', replyComment)
          ..add('datetime', datetime))
        .toString();
  }
}

class ReplyDetailsBuilder
    implements Builder<ReplyDetails, ReplyDetailsBuilder> {
  _$ReplyDetails? _$v;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  String? _replyComment;
  String? get replyComment => _$this._replyComment;
  set replyComment(String? replyComment) => _$this._replyComment = replyComment;

  DateTime? _datetime;
  DateTime? get datetime => _$this._datetime;
  set datetime(DateTime? datetime) => _$this._datetime = datetime;

  ReplyDetailsBuilder();

  ReplyDetailsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _username = $v.username;
      _replyComment = $v.replyComment;
      _datetime = $v.datetime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReplyDetails other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ReplyDetails;
  }

  @override
  void update(void Function(ReplyDetailsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ReplyDetails build() {
    final _$result = _$v ??
        new _$ReplyDetails._(
            username: username, replyComment: replyComment, datetime: datetime);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

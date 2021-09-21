// GENERATED CODE - DO NOT MODIFY BY HAND

part of blog_user;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BlogUser> _$blogUserSerializer = new _$BlogUserSerializer();

class _$BlogUserSerializer implements StructuredSerializer<BlogUser> {
  @override
  final Iterable<Type> types = const [BlogUser, _$BlogUser];
  @override
  final String wireName = 'BlogUser';

  @override
  Iterable<Object?> serialize(Serializers serializers, BlogUser object,
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
    return result;
  }

  @override
  BlogUser deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BlogUserBuilder();

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
      }
    }

    return result.build();
  }
}

class _$BlogUser extends BlogUser {
  @override
  final String? username;

  factory _$BlogUser([void Function(BlogUserBuilder)? updates]) =>
      (new BlogUserBuilder()..update(updates)).build();

  _$BlogUser._({this.username}) : super._();

  @override
  BlogUser rebuild(void Function(BlogUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BlogUserBuilder toBuilder() => new BlogUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BlogUser && username == other.username;
  }

  @override
  int get hashCode {
    return $jf($jc(0, username.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BlogUser')..add('username', username))
        .toString();
  }
}

class BlogUserBuilder implements Builder<BlogUser, BlogUserBuilder> {
  _$BlogUser? _$v;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  BlogUserBuilder();

  BlogUserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _username = $v.username;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BlogUser other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BlogUser;
  }

  @override
  void update(void Function(BlogUserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BlogUser build() {
    final _$result = _$v ?? new _$BlogUser._(username: username);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

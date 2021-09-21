// GENERATED CODE - DO NOT MODIFY BY HAND

part of app_state;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AppState> _$appStateSerializer = new _$AppStateSerializer();

class _$AppStateSerializer implements StructuredSerializer<AppState> {
  @override
  final Iterable<Type> types = const [AppState, _$AppState];
  @override
  final String wireName = 'AppState';

  @override
  Iterable<Object?> serialize(Serializers serializers, AppState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'blog',
      serializers.serialize(object.blog,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Blog)])),
      'user',
      serializers.serialize(object.user,
          specifiedType:
              const FullType(BuiltList, const [const FullType(BlogUser)])),
      'replyDetails',
      serializers.serialize(object.replyDetails,
          specifiedType:
              const FullType(BuiltList, const [const FullType(ReplyDetails)])),
    ];

    return result;
  }

  @override
  AppState deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AppStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'blog':
          result.blog.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Blog)]))!
              as BuiltList<Object?>);
          break;
        case 'user':
          result.user.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(BlogUser)]))!
              as BuiltList<Object?>);
          break;
        case 'replyDetails':
          result.replyDetails.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ReplyDetails)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$AppState extends AppState {
  @override
  final BuiltList<Blog> blog;
  @override
  final BuiltList<BlogUser> user;
  @override
  final BuiltList<ReplyDetails> replyDetails;

  factory _$AppState([void Function(AppStateBuilder)? updates]) =>
      (new AppStateBuilder()..update(updates)).build();

  _$AppState._(
      {required this.blog, required this.user, required this.replyDetails})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(blog, 'AppState', 'blog');
    BuiltValueNullFieldError.checkNotNull(user, 'AppState', 'user');
    BuiltValueNullFieldError.checkNotNull(
        replyDetails, 'AppState', 'replyDetails');
  }

  @override
  AppState rebuild(void Function(AppStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppStateBuilder toBuilder() => new AppStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppState &&
        blog == other.blog &&
        user == other.user &&
        replyDetails == other.replyDetails;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, blog.hashCode), user.hashCode), replyDetails.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppState')
          ..add('blog', blog)
          ..add('user', user)
          ..add('replyDetails', replyDetails))
        .toString();
  }
}

class AppStateBuilder implements Builder<AppState, AppStateBuilder> {
  _$AppState? _$v;

  ListBuilder<Blog>? _blog;
  ListBuilder<Blog> get blog => _$this._blog ??= new ListBuilder<Blog>();
  set blog(ListBuilder<Blog>? blog) => _$this._blog = blog;

  ListBuilder<BlogUser>? _user;
  ListBuilder<BlogUser> get user =>
      _$this._user ??= new ListBuilder<BlogUser>();
  set user(ListBuilder<BlogUser>? user) => _$this._user = user;

  ListBuilder<ReplyDetails>? _replyDetails;
  ListBuilder<ReplyDetails> get replyDetails =>
      _$this._replyDetails ??= new ListBuilder<ReplyDetails>();
  set replyDetails(ListBuilder<ReplyDetails>? replyDetails) =>
      _$this._replyDetails = replyDetails;

  AppStateBuilder();

  AppStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _blog = $v.blog.toBuilder();
      _user = $v.user.toBuilder();
      _replyDetails = $v.replyDetails.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AppState;
  }

  @override
  void update(void Function(AppStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AppState build() {
    _$AppState _$result;
    try {
      _$result = _$v ??
          new _$AppState._(
              blog: blog.build(),
              user: user.build(),
              replyDetails: replyDetails.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'blog';
        blog.build();
        _$failedField = 'user';
        user.build();
        _$failedField = 'replyDetails';
        replyDetails.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'AppState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

// GENERATED CODE - DO NOT MODIFY BY HAND

part of blog;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Blog> _$blogSerializer = new _$BlogSerializer();

class _$BlogSerializer implements StructuredSerializer<Blog> {
  @override
  final Iterable<Type> types = const [Blog, _$Blog];
  @override
  final String wireName = 'Blog';

  @override
  Iterable<Object?> serialize(Serializers serializers, Blog object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.title;
    if (value != null) {
      result
        ..add('title')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.content;
    if (value != null) {
      result
        ..add('content')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.author;
    if (value != null) {
      result
        ..add('author')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.docId;
    if (value != null) {
      result
        ..add('docId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.username;
    if (value != null) {
      result
        ..add('username')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.comment;
    if (value != null) {
      result
        ..add('comment')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.uid;
    if (value != null) {
      result
        ..add('uid')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.like;
    if (value != null) {
      result
        ..add('like')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    return result;
  }

  @override
  Blog deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BlogBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'content':
          result.content = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'author':
          result.author = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'docId':
          result.docId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'comment':
          result.comment = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'uid':
          result.uid = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'like':
          result.like.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$Blog extends Blog {
  @override
  final String? title;
  @override
  final String? content;
  @override
  final String? author;
  @override
  final String? docId;
  @override
  final String? username;
  @override
  final String? comment;
  @override
  final String? uid;
  @override
  final BuiltList<String>? like;

  factory _$Blog([void Function(BlogBuilder)? updates]) =>
      (new BlogBuilder()..update(updates)).build();

  _$Blog._(
      {this.title,
      this.content,
      this.author,
      this.docId,
      this.username,
      this.comment,
      this.uid,
      this.like})
      : super._();

  @override
  Blog rebuild(void Function(BlogBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BlogBuilder toBuilder() => new BlogBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Blog &&
        title == other.title &&
        content == other.content &&
        author == other.author &&
        docId == other.docId &&
        username == other.username &&
        comment == other.comment &&
        uid == other.uid &&
        like == other.like;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, title.hashCode), content.hashCode),
                            author.hashCode),
                        docId.hashCode),
                    username.hashCode),
                comment.hashCode),
            uid.hashCode),
        like.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Blog')
          ..add('title', title)
          ..add('content', content)
          ..add('author', author)
          ..add('docId', docId)
          ..add('username', username)
          ..add('comment', comment)
          ..add('uid', uid)
          ..add('like', like))
        .toString();
  }
}

class BlogBuilder implements Builder<Blog, BlogBuilder> {
  _$Blog? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  String? _author;
  String? get author => _$this._author;
  set author(String? author) => _$this._author = author;

  String? _docId;
  String? get docId => _$this._docId;
  set docId(String? docId) => _$this._docId = docId;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  String? _comment;
  String? get comment => _$this._comment;
  set comment(String? comment) => _$this._comment = comment;

  String? _uid;
  String? get uid => _$this._uid;
  set uid(String? uid) => _$this._uid = uid;

  ListBuilder<String>? _like;
  ListBuilder<String> get like => _$this._like ??= new ListBuilder<String>();
  set like(ListBuilder<String>? like) => _$this._like = like;

  BlogBuilder();

  BlogBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _content = $v.content;
      _author = $v.author;
      _docId = $v.docId;
      _username = $v.username;
      _comment = $v.comment;
      _uid = $v.uid;
      _like = $v.like?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Blog other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Blog;
  }

  @override
  void update(void Function(BlogBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Blog build() {
    _$Blog _$result;
    try {
      _$result = _$v ??
          new _$Blog._(
              title: title,
              content: content,
              author: author,
              docId: docId,
              username: username,
              comment: comment,
              uid: uid,
              like: _like?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'like';
        _like?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Blog', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

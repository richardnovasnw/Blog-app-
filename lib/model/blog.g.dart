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
    value = object.commentId;
    if (value != null) {
      result
        ..add('commentId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.commentID;
    if (value != null) {
      result
        ..add('commentID')
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
    value = object.like;
    if (value != null) {
      result
        ..add('like')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    value = object.reply;
    if (value != null) {
      result
        ..add('reply')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(ReplyDetails)])));
    }
    value = object.image;
    if (value != null) {
      result
        ..add('image')
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
      final key = iterator.current! as String;
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
        case 'commentId':
          result.commentId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'commentID':
          result.commentID = serializers.deserialize(value,
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
        case 'like':
          result.like.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'reply':
          result.reply.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ReplyDetails)]))!
              as BuiltList<Object?>);
          break;
        case 'image':
          result.image.replace(serializers.deserialize(value,
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
  final String? commentId;
  @override
  final String? commentID;
  @override
  final String? replyComment;
  @override
  final DateTime? datetime;
  @override
  final BuiltList<String>? like;
  @override
  final BuiltList<ReplyDetails>? reply;
  @override
  final BuiltList<String>? image;

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
      this.commentId,
      this.commentID,
      this.replyComment,
      this.datetime,
      this.like,
      this.reply,
      this.image})
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
        commentId == other.commentId &&
        commentID == other.commentID &&
        replyComment == other.replyComment &&
        datetime == other.datetime &&
        like == other.like &&
        reply == other.reply &&
        image == other.image;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc($jc(0, title.hashCode),
                                                        content.hashCode),
                                                    author.hashCode),
                                                docId.hashCode),
                                            username.hashCode),
                                        comment.hashCode),
                                    uid.hashCode),
                                commentId.hashCode),
                            commentID.hashCode),
                        replyComment.hashCode),
                    datetime.hashCode),
                like.hashCode),
            reply.hashCode),
        image.hashCode));
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
          ..add('commentId', commentId)
          ..add('commentID', commentID)
          ..add('replyComment', replyComment)
          ..add('datetime', datetime)
          ..add('like', like)
          ..add('reply', reply)
          ..add('image', image))
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

  String? _commentId;
  String? get commentId => _$this._commentId;
  set commentId(String? commentId) => _$this._commentId = commentId;

  String? _commentID;
  String? get commentID => _$this._commentID;
  set commentID(String? commentID) => _$this._commentID = commentID;

  String? _replyComment;
  String? get replyComment => _$this._replyComment;
  set replyComment(String? replyComment) => _$this._replyComment = replyComment;

  DateTime? _datetime;
  DateTime? get datetime => _$this._datetime;
  set datetime(DateTime? datetime) => _$this._datetime = datetime;

  ListBuilder<String>? _like;
  ListBuilder<String> get like => _$this._like ??= new ListBuilder<String>();
  set like(ListBuilder<String>? like) => _$this._like = like;

  ListBuilder<ReplyDetails>? _reply;
  ListBuilder<ReplyDetails> get reply =>
      _$this._reply ??= new ListBuilder<ReplyDetails>();
  set reply(ListBuilder<ReplyDetails>? reply) => _$this._reply = reply;

  ListBuilder<String>? _image;
  ListBuilder<String> get image => _$this._image ??= new ListBuilder<String>();
  set image(ListBuilder<String>? image) => _$this._image = image;

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
      _commentId = $v.commentId;
      _commentID = $v.commentID;
      _replyComment = $v.replyComment;
      _datetime = $v.datetime;
      _like = $v.like?.toBuilder();
      _reply = $v.reply?.toBuilder();
      _image = $v.image?.toBuilder();
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
              commentId: commentId,
              commentID: commentID,
              replyComment: replyComment,
              datetime: datetime,
              like: _like?.build(),
              reply: _reply?.build(),
              image: _image?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'like';
        _like?.build();
        _$failedField = 'reply';
        _reply?.build();
        _$failedField = 'image';
        _image?.build();
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

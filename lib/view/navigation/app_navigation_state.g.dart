// GENERATED CODE - DO NOT MODIFY BY HAND

part of app_navigation_state;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AppNavigationState> _$appNavigationStateSerializer =
    new _$AppNavigationStateSerializer();

class _$AppNavigationStateSerializer
    implements StructuredSerializer<AppNavigationState> {
  @override
  final Iterable<Type> types = const [AppNavigationState, _$AppNavigationState];
  @override
  final String wireName = 'AppNavigationState';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, AppNavigationState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.initialRoute;
    if (value != null) {
      result
        ..add('initialRoute')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(InitialRoute)));
    }
    value = object.homeRoute;
    if (value != null) {
      result
        ..add('homeRoute')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(HomeRoute)));
    }
    return result;
  }

  @override
  AppNavigationState deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AppNavigationStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'initialRoute':
          result.initialRoute = serializers.deserialize(value,
              specifiedType: const FullType(InitialRoute)) as InitialRoute?;
          break;
        case 'homeRoute':
          result.homeRoute = serializers.deserialize(value,
              specifiedType: const FullType(HomeRoute)) as HomeRoute?;
          break;
      }
    }

    return result.build();
  }
}

class _$AppNavigationState extends AppNavigationState {
  @override
  final InitialRoute? initialRoute;
  @override
  final HomeRoute? homeRoute;

  factory _$AppNavigationState(
          [void Function(AppNavigationStateBuilder)? updates]) =>
      (new AppNavigationStateBuilder()..update(updates)).build();

  _$AppNavigationState._({this.initialRoute, this.homeRoute}) : super._();

  @override
  AppNavigationState rebuild(
          void Function(AppNavigationStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppNavigationStateBuilder toBuilder() =>
      new AppNavigationStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppNavigationState &&
        initialRoute == other.initialRoute &&
        homeRoute == other.homeRoute;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, initialRoute.hashCode), homeRoute.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppNavigationState')
          ..add('initialRoute', initialRoute)
          ..add('homeRoute', homeRoute))
        .toString();
  }
}

class AppNavigationStateBuilder
    implements Builder<AppNavigationState, AppNavigationStateBuilder> {
  _$AppNavigationState? _$v;

  InitialRoute? _initialRoute;
  InitialRoute? get initialRoute => _$this._initialRoute;
  set initialRoute(InitialRoute? initialRoute) =>
      _$this._initialRoute = initialRoute;

  HomeRoute? _homeRoute;
  HomeRoute? get homeRoute => _$this._homeRoute;
  set homeRoute(HomeRoute? homeRoute) => _$this._homeRoute = homeRoute;

  AppNavigationStateBuilder() {
    AppNavigationState._initializeBuilder(this);
  }

  AppNavigationStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _initialRoute = $v.initialRoute;
      _homeRoute = $v.homeRoute;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppNavigationState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AppNavigationState;
  }

  @override
  void update(void Function(AppNavigationStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AppNavigationState build() {
    final _$result = _$v ??
        new _$AppNavigationState._(
            initialRoute: initialRoute, homeRoute: homeRoute);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

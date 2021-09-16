library app_navigation_state;

import 'package:blog/model/serializer.dart';
import 'package:blog/view/navigation/app_navigation_controller.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'app_navigation_state.g.dart';

abstract class AppNavigationState
    implements Built<AppNavigationState, AppNavigationStateBuilder> {
  factory AppNavigationState(
          [void Function(AppNavigationStateBuilder)? updates]) =
      _$AppNavigationState;

  AppNavigationState._();

  Map<String, dynamic>? toJson() {
    return serializers.serializeWith(AppNavigationState.serializer, this)
        as Map<String, dynamic>?;
  }

  static AppNavigationState? fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(AppNavigationState.serializer, json);
  }

  static Serializer<AppNavigationState> get serializer =>
      _$appNavigationStateSerializer;

  static void _initializeBuilder(AppNavigationStateBuilder b) {}

  InitialRoute? get initialRoute;
  HomeRoute? get homeRoute;

}

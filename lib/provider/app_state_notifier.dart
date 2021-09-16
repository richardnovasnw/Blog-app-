import 'package:state_notifier/state_notifier.dart';

abstract class AppStateNotifier<T> extends StateNotifier<T> {
  AppStateNotifier(T state) : super(state);

  void init() {
    print('initializing');
  }
}

import 'package:blog/view_modal/app_view_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension ProviderUtils on BuildContext {
  AppViewModel get appViewModel => read<AppViewModel>();

}

// mixin AppProviderMixin<S extends StatefulWidget> on State<S> {
//   AppState get appState => context.watch<AppState>();
// }

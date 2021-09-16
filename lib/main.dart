import 'package:blog/core/navigation/navigation.dart';
import 'package:blog/provider/provider_utils.dart';
import 'package:blog/view/navigation/app_navigation_state.dart';
import 'package:blog/view_modal/app_view_modal.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'view/navigation/app_navigation_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AppProvider(
    child: StateNotifierProvider<AppNavigationController, AppNavigationState>(
      create: (_) => AppNavigationController()..init(),
      child: const MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Blog',
      routeInformationParser: AppRouteParser(),
      routerDelegate:
          AppRouteDelegate<AppNavigationController>(context.navigation),
    );
  }
}

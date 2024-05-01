import 'package:flutter/material.dart';
import 'package:movies/core/config/app-theme.dart';

import 'core/config/pages_Route_Name.dart';
import 'core/config/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
GlobalKey<NavigatorState> navigatorkey=GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Appthemes.theme,
      initialRoute: PageRouteName.initial,
      onGenerateRoute: Routes.onGenrateRoutes,
      themeMode: ThemeMode.light,
      navigatorKey: navigatorkey,
      debugShowCheckedModeBanner: false,

    );
  }
}

import 'package:flutter/material.dart';
import 'config/routes/app_routes.dart';
import 'config/themes/app_themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppThemes.lighTheme,
      initialRoute: AppRoute.intialRoute,
      routes: AppRoute.routes,
    );
  }
}

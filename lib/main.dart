import 'package:flutter/material.dart';
import 'package:todo_sun_c11/ui/screens/home/home.dart';
import 'package:todo_sun_c11/ui/utils/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routes: {
        Home.routeName: (_) => const Home()
      },
      initialRoute: Home.routeName,
    );
  }
}

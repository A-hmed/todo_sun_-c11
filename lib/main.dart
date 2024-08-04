import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_sun_c11/ui/screens/home/home.dart';
import 'package:todo_sun_c11/ui/utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyBVfEAbhtm1IlSXJ-cbZoPn0PKnh-EZ8so",
        appId: "1:1016583357933:android:9e85090dd75b55761a93e4",
        messagingSenderId: "todo-sun-c11",
        projectId: "todo-sun-c11"),
  );
  await FirebaseFirestore.instance.disableNetwork();
  FirebaseFirestore.instance.settings =
      Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
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

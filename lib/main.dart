import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pad_tracker/screens/authentication/logIN.dart';
import 'package:pad_tracker/screens/authentication/register.dart';
import 'package:pad_tracker/screens/home/Home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBXvHIIGwbqepYCvU6g6l1vuRoce9mzo4I",
          authDomain: "padtracker-9b66a.firebaseapp.com",
          projectId: "padtracker-9b66a",
          storageBucket: "padtracker-9b66a.appspot.com",
          messagingSenderId: "354177003085",
          appId: "1:354177003085:web:63eb7b59db593f3c107604"));
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'signUp',
    routes: {
      '/': (context) => const LogIn(),
      'signUp': (context) => const Register(),
      'home': (context) => const Home()
    },
  ));
}

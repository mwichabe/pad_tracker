import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pad_tracker/screens/authentication/logIN.dart';
import 'package:pad_tracker/screens/authentication/register.dart';
import 'package:pad_tracker/screens/home/Home.dart';


Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'signUp',
    routes: {
      '/' : (context)=> const LogIn(),
      'signUp': (context)=> const Register(),
      'home': (context)=> const Home()

    },
  ));
}


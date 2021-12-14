import 'package:flutter/material.dart';
import 'package:spartans_eatup/src/login.dart';
import 'package:spartans_eatup/src/navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'src/navbar.dart';
import 'package:get/get.dart';
void main() async {
  //TODO Use future builder so that APP UI builds before Firebase initializes

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  bool loggedIn = false;

  // Taken from https://firebase.flutter.dev/docs/auth/usage/
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
      loggedIn = false;
    } else {
      print('User is signed in!');
      loggedIn = true;
    }
  });

 runApp(GetMaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spartans, Eat Up',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Login(),
    );
  }
}

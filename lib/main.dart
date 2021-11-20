import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spartans_eatup/src/home_page.dart';
import 'src/student_login_page.dart';
import 'src/student_registration_page.dart';

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

  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {

  @override
  StudentLoginPage createState() => StudentLoginPage();
}

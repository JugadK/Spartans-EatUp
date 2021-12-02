import 'package:flutter/material.dart';
import 'package:spartans_eatup/main.dart';
import 'package:spartans_eatup/src/models/order.dart';
import 'package:spartans_eatup/src/models/order_list.dart';
import 'package:spartans_eatup/src/models/student.dart';
import 'package:spartans_eatup/src/student_login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/*class StudentRegistrationPage extends State<MyApp> {
  static final _registerFormKey = GlobalKey<FormState>();

  // Used in order to read values from Registration Form
  static TextEditingController registrationEmailController =
      TextEditingController();
  static TextEditingController registrationPasswordController =
      TextEditingController();

  Future<void> registerUser() async {
    String email = registrationEmailController.text;
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: registrationPasswordController.text,
      );

      User? user = userCredential.user;

      CollectionReference students =
          FirebaseFirestore.instance.collection('students');

      // Call the user's CollectionReference to add a new user
      //students.add(Student(email: email, orders: []).toJson());
      await students
          .doc(
            FirebaseAuth.instance.currentUser!.uid.toString(),
          )
          .set(Student(email: email, orders: []).toJson())
          .catchError((error) => print("Failed to add user: $error"));

      //Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    //Code modified from from https://docs.flutter.dev/cookbook/forms/validation
    return Scaffold(
        backgroundColor: Colors.blue[900],
        body: Center(
            child: Form(
                key: _registerFormKey,
                child: Container(
                    width: width * 0.8,
                    height: height * 0.35,
                    decoration: const BoxDecoration(
                        color: Color(0xffffb913),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            spreadRadius: 3,
                            blurRadius: 7,
                          )
                        ]),
                    //color: Colors.amber[700],
                    child: Column(children: [
                      TextFormField(
                        controller: registrationEmailController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Email",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Email';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: registrationPasswordController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Password"),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Password';
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue[900],
                          ),
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_registerFormKey.currentState!.validate()) {
                              registerUser();
                              //print(registrationEmailController.text);
                              //print(registrationPasswordController.text);

                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Processing Data')),
                              );
                            }
                          },
                          child: const Text('EatUp'),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          // Navigator.of(context).push(MaterialPageRoute(
                          //    builder: (context) =>
                          //       StudentLoginPage().build(context)));
                        },
                        child: Text("Go to Login"),
                      )
                    ])))));
  }
} */

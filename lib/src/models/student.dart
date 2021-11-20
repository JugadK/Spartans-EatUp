import 'package:spartans_eatup/main.dart';
import 'package:flutter/material.dart';
import 'package:spartans_eatup/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

@immutable
class Student {
  final String email;
  final String uid;

  Student({
    required this.email,
    required this.uid,
  });

  Student.fromJson(Map<String, Object?> json)
      : this(
          email: json['genre']! as String,
          uid: json['likes']! as String,
        );
}

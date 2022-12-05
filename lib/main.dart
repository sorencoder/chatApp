import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/screen/completeProfile.dart';
import 'package:chatapp/screen/loginPage.dart';
import 'package:chatapp/screen/signUp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(
    title: 'Chat App',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const LoginPage(),
  ));
}

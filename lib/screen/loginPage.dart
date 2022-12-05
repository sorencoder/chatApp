import 'dart:developer';

import 'package:chatapp/model/UserModel.dart';
import 'package:chatapp/screen/completeProfile.dart';
import 'package:chatapp/screen/homepage.dart';

import 'package:chatapp/screen/signUp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FocusNode _focusNode = FocusNode();
  bool _isObscure = true;

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  void check() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (email == '' && password == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('please fill all the fields'),
        backgroundColor: Colors.red[300],
      ));
    } else {
      login(email, password);
    }
  }

  void login(String email, String password) async {
    UserCredential? credential;
    try {
      credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
    if (credential != null) {
      String uid = credential.user!.uid;
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
              fullscreenDialog: true, builder: (context) => const HomePage()));
      DocumentSnapshot userData =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      // log(userData.toString());
      UserModel userModel =
          UserModel.fromMap(userData.data() as Map<String, dynamic>);
      // log('login successful');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('login successful'),
        backgroundColor: Colors.green[300],
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    log('building');
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.teal[100],
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Chat App',
                style: TextStyle(
                    fontSize: 50,
                    color: Colors.blue,
                    fontFamily: 'Courgette',
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 18,
              ),
              Container(
                height: 450,
                width: 450,
                decoration: BoxDecoration(
                    color: Colors.teal[200],
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.blue,
                        fontFamily: 'Courgette',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
                      child: TextField(
                        controller: emailController,
                        onSubmitted: (value) {
                          if (value != '') {
                            _focusNode.requestFocus();
                          }
                        },
                        decoration: const InputDecoration(
                            labelText: 'Email', border: OutlineInputBorder()),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
                      child: TextField(
                        obscureText: _isObscure ? true : false,
                        controller: passwordController,
                        focusNode: _focusNode,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                },
                                icon: Icon(_isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                            labelText: 'Password',
                            border: const OutlineInputBorder()),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    OutlinedButton(
                        onPressed: () {
                          check();
                        },
                        child: const Text(
                          'Login',
                        )),
                    Flexible(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          fullscreenDialog: true,
                                          builder: (context) =>
                                              const SignUpPage()));
                                },
                                child: const Text('Sign Up'))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

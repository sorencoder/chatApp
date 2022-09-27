import 'dart:developer';

import 'package:chatapp/screen/completeProfile.dart';
import 'package:chatapp/screen/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FocusNode _focusNode = FocusNode();

  final FocusNode _focusNode1 = FocusNode();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController cfpasswordController = TextEditingController();

  void check() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cfpassword = cfpasswordController.text.trim();
    if (email == '' || password == '' || cfpassword == '') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('please fill all the fields'),
        backgroundColor: Colors.redAccent,
      ));
    } else if (password != cfpassword) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('password do not match'),
        backgroundColor: Colors.red[200],
      ));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => const CompleteProfile()));
      singUp(email, password);
    }
  }

  void singUp(String email, String password) async {
    UserCredential? credential;
    credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 450,
              width: 450,
              // color: Colors.teal,
              // color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Chat App',
                    style: TextStyle(
                        fontSize: 50,
                        color: Colors.blue,
                        fontFamily: 'Courgette',
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: emailController,
                    onSubmitted: (value) {
                      if (value != '') {
                        _focusNode.requestFocus();
                      }
                    },
                    decoration: const InputDecoration(
                        labelText: 'Email',
                        // hintText: 'email',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    obscureText: true,
                    focusNode: _focusNode,
                    controller: passwordController,
                    onSubmitted: (value) {
                      if (value != '') {
                        _focusNode1.requestFocus();
                      }
                    },
                    decoration: const InputDecoration(
                        labelText: 'Password',
                        // hintText: 'password',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    obscureText: true,
                    controller: cfpasswordController,
                    focusNode: _focusNode1,
                    decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        check();
                      },
                      child: const Text('Sign Up')),
                ],
              ),
            ),
            Flexible(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                fullscreenDialog: true,
                                builder: (context) => LoginPage()));
                      },
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:chatapp/model/UserModel.dart';
import 'package:chatapp/screen/completeProfile.dart';
import 'package:chatapp/screen/loginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isObscureps = true;
  bool _isObscurecfps = true;
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
      singUp(email, password);
    }
  }

  void singUp(String email, String password) async {
    UserCredential? credential;
    try {
      credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // print(credential.user);
    } on FirebaseAuthException catch (e) {
      log(e.code.toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
    if (credential != null) {
      String uid = credential.user!.uid;
      UserModel newUser = UserModel(
        uid: uid,
        email: email,
        profilepic: '',
        fullname: '',
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set(newUser.toMap())
          .then((value) => print('new user created'));
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         fullscreenDialog: true,
      //         builder: (context) => const CompleteProfile()));
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Sign Up',
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
                              labelText: 'Email',
                              // hintText: 'email',
                              border: OutlineInputBorder()),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
                        child: TextField(
                          obscureText: _isObscureps ? true : false,
                          focusNode: _focusNode,
                          controller: passwordController,
                          onSubmitted: (value) {
                            if (value != '') {
                              _focusNode1.requestFocus();
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'Password',
                              // hintText: 'password',
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isObscureps = !_isObscureps;
                                    });
                                  },
                                  icon: Icon(_isObscureps
                                      ? Icons.visibility
                                      : Icons.visibility_off)),
                              border: const OutlineInputBorder()),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
                        child: TextField(
                          obscureText: _isObscurecfps ? true : false,
                          controller: cfpasswordController,
                          focusNode: _focusNode1,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isObscurecfps = !_isObscurecfps;
                                    });
                                  },
                                  icon: Icon(_isObscurecfps
                                      ? Icons.visibility
                                      : Icons.visibility_off)),
                              labelText: 'Confirm Password',
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
                          child: const Text('Sign Up')),
                      Flexible(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Already have an account?'),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              fullscreenDialog: true,
                                              builder: (context) =>
                                                  const LoginPage()));
                                    },
                                    child: const Text('Login'))
                              ]),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

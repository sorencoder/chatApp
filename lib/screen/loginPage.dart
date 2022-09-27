import 'package:chatapp/screen/homepage.dart';
import 'package:chatapp/screen/signUp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FocusNode _focusNode = FocusNode();
  bool isFill = false;

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  void check() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (email != '' && password != '') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('please fill all the fields'),
        backgroundColor: Colors.red[300],
      ));
    }
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
                        labelText: 'Email', border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    obscureText: true,
                    controller: passwordController,
                    focusNode: _focusNode,
                    decoration: const InputDecoration(
                        labelText: 'Password', border: OutlineInputBorder()),
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
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                fullscreenDialog: true,
                                builder: (context) => SignUpPage()));
                      },
                      child: const Text('Sign Up'),
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

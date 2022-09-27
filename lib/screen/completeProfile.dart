import 'package:chatapp/screen/loginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CompleteProfile extends StatelessWidget {
  const CompleteProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        elevation: 0,
      ),
      body: Center(
        child: Container(
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
                    fontSize: 50, color: Colors.blue, fontFamily: 'Courgette'),
              ),
              const SizedBox(
                height: 10,
              ),
              const CircleAvatar(
                radius: 40,
                child: Icon(
                  Icons.person,
                  size: 30,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const TextField(
                decoration: InputDecoration(
                    labelText: 'Full Name', border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 10,
              ),
              OutlinedButton(onPressed: () {}, child: const Text('Submit')),
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
      ),
    );
  }
}

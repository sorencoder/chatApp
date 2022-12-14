import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Chat App',
            style: TextStyle(fontFamily: 'Courgette'),
          ),
        ),
        body: const Center(
          child: Text(
            'Home Page',
            style: TextStyle(fontFamily: 'Courgette', fontSize: 50),
          ),
        ),
      ),
    );
  }
}

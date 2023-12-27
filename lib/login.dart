import 'package:flutter/material.dart';
import 'package:integration_testing/homepage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _usernameController = TextEditingController();
  final _passWordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passWordController.dispose();
  }

  void _login() {
    if (_usernameController.text == 'username' &&
        _passWordController.text == 'password') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => const HomePage())));
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Invalid username or password'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            key: const Key('username_controller'),
            controller: _usernameController,
            decoration: const InputDecoration(labelText: 'Username'),
          ),
          TextField(
            key: const Key('password_controller'),
            controller: _passWordController,
            decoration: const InputDecoration(labelText: 'Password'),
          ),
          ElevatedButton(
              key: const Key('login'),
              onPressed: () {
                _login();
              },
              child: const Text('Login'))
        ],
      )),
    );
  }
}

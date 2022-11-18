import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              enableSuggestions: true,
              autocorrect: false,
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            TextField(
              controller: _password,
              keyboardType: TextInputType.text,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(hintText: 'Password'),
            ),
            ElevatedButton(
              onPressed: () => login(),
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(
                context,
                'register',
                arguments: {'email': _email.value},
              ),
              child: const Text('Create account'),
            )
          ],
        ),
      ),
    );
  }

  Future<void> login() async {
    final email = _email.text;
    final password = _password.text;
    try {
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(user);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      Fluttertoast.showToast(
          msg: " The email address or password are incorrect ",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black87,
          fontSize: 12);
    }
    //Navigator.pushReplacementNamed(context, 'home');
  }
}

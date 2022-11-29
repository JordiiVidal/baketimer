import 'dart:developer';

import 'package:baketimer/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../widgets/auth_column.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _passwordRepeat;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _passwordRepeat = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _passwordRepeat.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: AuthColumn(
          children: [
            SizedBox(
              height: 100,
              child: Column(
                children: const [
                  Text(
                    'BAKETIMER',
                    style: TextStyle(
                      fontSize: 34,
                    ),
                  ),
                  Text(
                    'CREATE ACCOUNT',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black38,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            TextField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              enableSuggestions: true,
              autocorrect: false,
              decoration: const InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: _password,
              keyboardType: TextInputType.text,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: _passwordRepeat,
              keyboardType: TextInputType.text,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                hintText: 'Repeat Password',
                border: OutlineInputBorder(),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 16.0,
              ),
              child: ElevatedButton(
                onPressed: () => register(),
                style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  child: Text('Register'),
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(
                context,
                '/login/',
              ),
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  void register() async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    var msg = 'The email address or password are incorrect';
    if (!_formKey.currentState!.validate()) {
      await showSnackbar(context, msg);
      return;
    }
    final email = _email.text;
    final password = _password.text;
    try {
      final auth = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await auth.user?.sendEmailVerification();
      if (!mounted) return;
      final route = (auth.user?.emailVerified ?? false)
          ? productsRoute
          : verifyEmailRoute;
      Navigator.of(context).pushNamed(route);
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      if (e.code == 'weak-password') {
        msg = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        msg = 'The account already exists for that email.';
      }
      await showSnackbar(context, msg);
    } catch (e) {
      log(e.toString());
      await showSnackbar(context, msg);
    }
  }

  showSnackbar(context, message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

import 'package:baketimer/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../utilities/show_error_toast.dart';
import '../../widgets/auth_column.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController
      _email; //late promise i will give value variable
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
      body: AuthColumn(
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
            height: 16,
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
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                final auth =
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                await auth.user?.sendEmailVerification();
                if (!mounted) return;
                final route = (auth.user?.emailVerified ?? false)
                    ? productsRoute
                    : verifyEmaiRoute;
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(route, (route) => false);
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  showErrorToast('The password provided is too weak.');
                } else if (e.code == 'email-already-in-use') {
                  showErrorToast('The account already exists for that email.');
                }
              } catch (e) {
                showErrorToast(
                    'The email address provided may be registered already.');
              }
            },
            child: const Text('Register'),
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
    );
  }
}

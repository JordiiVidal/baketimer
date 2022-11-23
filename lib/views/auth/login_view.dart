import 'package:baketimer/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../widgets/auth_column.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final user = FirebaseAuth.instance.currentUser;
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
      body: AuthColumn(
        children: [
          TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            enableSuggestions: true,
            autocorrect: true,
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
              registerRoute,
              arguments: {'email': _email.value},
            ),
            child: const Text('Create account'),
          )
        ],
      ),
    );
  }

  void login() async {
    final email = _email.text;
    final password = _password.text;
    try {
      final auth = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!mounted) return;
      if (auth.user?.emailVerified ?? false) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(productsRoute, (route) => false);
      } else {
        Navigator.of(context).pushNamed(verifyEmaiRoute);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showError();
      } else if (e.code == 'wrong-password') {
        showError();
      }
    } catch (e) {
      showError();
    }
    //Navigator.pushReplacementNamed(context, '/home/');
  }

  showError() {
    Fluttertoast.showToast(
      msg: ' The email address or password are incorrect ',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black87,
      fontSize: 12,
    );
  }
}

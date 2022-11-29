import 'package:baketimer/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../utilities/validation.dart';
import '../../widgets/auth_column.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final user = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool _showPassword = false;

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
                    'WELCOME',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black38,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            TextFormField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              enableSuggestions: true,
              autocorrect: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                labelText: 'Email',
                errorStyle: TextStyle(height: 0),
                hintText: 'Enter your email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              validator: validatorEmail,
            ),
            const SizedBox(
              height: 16.0,
            ),
            TextFormField(
              controller: _password,
              keyboardType: TextInputType.text,
              obscureText: _showPassword ? false : true,
              enableSuggestions: false,
              autocorrect: false,
              enableInteractiveSelection: true,
              toolbarOptions: const ToolbarOptions(
                copy: false,
                paste: false,
                cut: false,
                selectAll: false,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: GestureDetector(
                  onTap: (() => setState(() => _showPassword = !_showPassword)),
                  child: Icon(
                    _showPassword
                        ? Icons.remove_red_eye
                        : Icons.remove_red_eye_outlined,
                  ),
                ),
              ),
              validator: validatorPassword,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 16.0,
              ),
              child: ElevatedButton(
                onPressed: () => login(),
                style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  child: Text('Login'),
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(
                context,
                registerRoute,
                arguments: {'email': _email.text},
              ),
              child: const Text(
                'Create account',
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void login() async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    var msg = 'The email address or password are incorrect';
    if (!_formKey.currentState!.validate()) {
      await showSnackbar(context, msg);
      return;
    }
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
        Navigator.of(context).pushNamed(verifyEmailRoute);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        msg = 'User not found';
      } else if (e.code == 'wrong-password') {
        msg = 'Wrong credentials';
      }
      await showSnackbar(context, msg);
    } catch (e) {
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

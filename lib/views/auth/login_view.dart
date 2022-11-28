import 'package:baketimer/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../utilities/show_error_toast.dart';
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
      body: AuthColumn(
        children: [
          const SizedBox(
            height: 100,
            child: Text(
              'BAKETIMER',
              style: TextStyle(
                fontSize: 34,
              ),
            ),
          ),
          TextFormField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            enableSuggestions: true,
            autocorrect: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              labelText: 'Email',
              errorStyle: const TextStyle(height: 0),
              hintText: 'Enter your email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              prefixIcon: const Icon(Icons.email),
            ),
            validator: _validatorEmail,
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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
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
            validator: _validatorPassword,
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
    );
  }

  void login() async {
    var msg = 'The email address or password are incorrect';
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
        msg = 'User not found';
      } else if (e.code == 'wrong-password') {
        msg = 'Wrong credentials';
      }
      await showErrorToast(msg);
    } catch (e) {
      await showErrorToast(msg);
    }
  }

  String? _validatorEmail(text) {
    return (text.isEmpty || text.length < 4) ? '' : null;
  }

  String? _validatorPassword(txt) {
    if (txt == null || txt.isEmpty) {
      return "Invalid password!";
    }
    if (txt.length < 8) {
      return "Password must has 8 characters";
    }
    if (!txt.contains(RegExp(r'[A-Z]'))) {
      return "Password must has uppercase";
    }
    if (!txt.contains(RegExp(r'[0-9]'))) {
      return "Password must has digits";
    }
    if (!txt.contains(RegExp(r'[a-z]'))) {
      return "Password must has lowercase";
    }
    if (!txt.contains(RegExp(r'[#?!@$%^&*-]'))) {
      return "Password must has special characters";
    }
    return null;
  }
}

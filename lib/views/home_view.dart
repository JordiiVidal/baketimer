import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  Future<void> logout(BuildContext context, VoidCallback onSuccess) async {
    await FirebaseAuth.instance.signOut();
    onSuccess.call();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () => logout(
              context,
              () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  'login',
                  (route) => false,
                );
              },
            ),
            icon: const Icon(Icons.logout_rounded),
          )
        ],
      ),
      body: const Text('Home'),
    );
  }
}

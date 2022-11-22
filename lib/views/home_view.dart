import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () => logoutDialog(context).then(
              (shouldLogout) {
                if (shouldLogout) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, 'login', (route) => false);
                }
              },
            ),
            icon: const Icon(Icons.exit_to_app_rounded),
          )
        ],
      ),
      body: const Text('Home'),
    );
  }

  Future<bool> logoutDialog(BuildContext context) async {
    return showModalBottomSheet<bool>(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Are you sure you want to sign out?'),
              const SizedBox(
                height: 26.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Log out'),
                  )
                ],
              )
            ],
          ),
        );
      },
    ).then(
      (value) async {
        if (value == true) await FirebaseAuth.instance.signOut();
        return value ?? false;
      },
    );
    //await FirebaseAuth.instance.signOut();
  }
}

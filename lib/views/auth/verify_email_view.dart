import 'package:baketimer/constants/routes.dart';
import 'package:baketimer/widgets/auth_column.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthColumn(
        children: [
          const Text(
            'We\'are happy you signed up for Baketimer. To start exploring the Baketimer App, please confirm your email address.',
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              if (user?.emailVerified ?? false) {
                Navigator.restorablePushNamedAndRemoveUntil(
                  context,
                  productsRoute,
                  (route) => false,
                );
              }
              //TODO Feedback msg
            },
            child: const Text('Enter'),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "If tou haven't received a verification email yet, press the button below",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54),
          ),
          TextButton(
            onPressed: () async {
              //TODO MAX 5 min cooldown
              final user = FirebaseAuth.instance.currentUser;
              await user?.sendEmailVerification();
            },
            child: const Text('Resend email confirmation'),
          )
        ],
      ),
    );
  }
}

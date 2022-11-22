import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:baketimer/views/auth/login_view.dart';
import 'package:baketimer/views/auth/verify_email_view.dart';
import 'package:baketimer/views/home_view.dart';
import 'package:baketimer/views/loading_view.dart';
import 'package:baketimer/views/products/products_create_view.dart';
import 'package:baketimer/views/products/products_list_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Backtimer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              log(user.toString());
              if (user != null) {
                if (user.emailVerified) {
                  return const HomeView();
                }
                return const VerifyEmailView();
              }
              return const LoginView();
            default:
              return const LoadingView();
          }
        },
      ),
      routes: {
        'login': (context) => const LoginView(),
        'home': (context) => const HomeView(),
        'products-list': (context) => const ProductsListView(),
        'products-create': (context) => const ProductsCreateView(),
      },
    );
  }
}

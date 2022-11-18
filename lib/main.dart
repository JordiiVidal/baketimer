import 'package:flutter/material.dart';
import 'package:baketimer/views/login_view.dart';
import 'package:baketimer/views/register_view.dart';
import 'package:baketimer/views/home_view.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Backtimer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'home',
      routes: {
        'login': (context) => const LoginView(),
        'register': (context) => const RegisterView(),
        'home': (context) => const HomeView(),
      },
    ),
  );
}

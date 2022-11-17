import 'package:flutter/material.dart';
import 'package:baketimer/views/home_view.dart';
import 'package:baketimer/views/register_view.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Backtimer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'register',
      routes: {
        'home': (context) => const HomeView(),
        'register': (context) => const RegisterView(),
      },
    ),
  );
}

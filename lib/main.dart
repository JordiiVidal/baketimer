import 'package:baketimer/pages/bake_details_page.dart';
import 'package:baketimer/pages/bake_list_page.dart';
import 'package:baketimer/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Backtimer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        'homepage': (context) => const HomePage(),
        'bakes': (context) => const BakeListPage(),
        'bake': (context) => const BakeDetailsPage(),
      },
    );
  }
}

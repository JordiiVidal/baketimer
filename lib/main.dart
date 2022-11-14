import 'package:flutter/material.dart';
import 'package:baketimer/views/bakes/bake_details_view.dart';
import 'package:baketimer/views/bakes/bake_list_view.dart';
import 'package:baketimer/views/home_page.dart';

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
        'bakes': (context) => const BakeListView(),
        'bake': (context) => const BakeDetailsView(),
      },
    );
  }
}

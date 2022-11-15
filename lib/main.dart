import 'package:flutter/material.dart';
import 'package:baketimer/views/dashboard_view.dart';
import 'package:baketimer/views/products/products_list_view.dart';

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
      initialRoute: 'products',
      routes: {
        'dashboard': (context) => const DashboardView(),
        'products': (context) => const ProductsListView(),
      },
    );
  }
}

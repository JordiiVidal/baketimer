import 'package:baketimer/constants/routes.dart';
import 'package:baketimer/widgets/popup_menu.dart';
import 'package:flutter/material.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, productsCreateRoute),
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          const PopupMenu(),
        ],
      ),
      body: Container(),
    );
  }
}

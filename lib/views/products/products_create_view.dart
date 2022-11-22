import 'package:flutter/material.dart';

class ProductsCreateView extends StatefulWidget {
  const ProductsCreateView({super.key});

  @override
  State<ProductsCreateView> createState() => _ProductsCreateViewState();
}

class _ProductsCreateViewState extends State<ProductsCreateView> {
  late final TextEditingController _name;
  late final TextEditingController _brand;

  @override
  void initState() {
    _name = TextEditingController();
    _brand = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _brand.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
            controller: _name,
            decoration: const InputDecoration(
              hintText: 'Name',
            ),
          ),
          TextField(
            controller: _brand,
             decoration: const InputDecoration(
              hintText: 'Brand',
            ),
          ),
          ElevatedButton(
            onPressed: null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Create'),
                Icon(Icons.add),
              ],
            ),
          )
        ],
      ),
    );
  }
}

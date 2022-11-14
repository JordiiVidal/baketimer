import 'bake.dart';

class Product {
  Product({
    required this.id,
    required this.name,
    required this.brand,
    this.bakes = const [],

  });

  String id;
  String name;
  String brand;
  List<Bake> bakes;
}
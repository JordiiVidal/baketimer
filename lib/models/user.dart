import 'package:baketimer/models/product.dart';

class User {
  User({
    required this.email,
    required this.password,
    this.products = const [],
  });
  String email;
  String password;
  List<Product> products;
}

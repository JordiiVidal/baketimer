import 'package:baketimer/models/timer.dart';

class Bake {
  Bake({
    required this.id,
    required this.name,
    required this.description,
    required this.product,
    required this.brand,
    this.categories = const [],
    this.timers = const [],
  });

  String id;
  String name;
  String description;
  String product;
  String brand;
  List<String> categories;
  List<Timer> timers;
  
}

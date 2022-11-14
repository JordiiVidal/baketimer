import 'package:baketimer/models/timer.dart';

class Bake {
  Bake({
    required this.id,
    required this.name,
    required this.description,
    this.categories = const [],
    this.timers = const [],
  });

  String id;
  String name;
  String description;
  List<String> categories;
  List<Timer> timers;
  
}

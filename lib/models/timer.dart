import '../enums/heat_type.dart';

class Timer {
    Timer({
        required this.id,
        required this.step,
        required this.heat,
        required this.duration,
        this.tips = const [],
    });

    String id;
    int step;
    HeatType heat;
    int duration;
    List<String> tips;
}

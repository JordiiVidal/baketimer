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
    String heat;
    int duration;
    List<String> tips;
}

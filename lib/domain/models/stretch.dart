class Stretch {
  final String name;
  final String duration;

  const Stretch({required this.name, required this.duration});

  /// Parses "30s", "45s × 2" → total seconds
  int get totalSeconds {
    final m = RegExp(r'(\d+)s(?:\s*×\s*(\d+))?').firstMatch(duration);
    if (m == null) return 30;
    final base = int.parse(m.group(1)!);
    final reps = m.group(2) != null ? int.parse(m.group(2)!) : 1;
    return base * reps;
  }
}

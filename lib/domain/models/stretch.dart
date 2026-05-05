class Stretch {
  final String name;
  final String duration;
  final String description;
  final String category; // StretchCategory constants

  const Stretch({
    required this.name,
    required this.duration,
    required this.description,
    required this.category,
  });

  /// Parses "30s", "45s × 2" → total seconds
  int get totalSeconds {
    final m = RegExp(r'(\d+)s(?:\s*×\s*(\d+))?').firstMatch(duration);
    if (m == null) return 30;
    final base = int.parse(m.group(1)!);
    final reps = m.group(2) != null ? int.parse(m.group(2)!) : 1;
    return base * reps;
  }
}

abstract final class StretchCategory {
  static const neck      = 'neck';
  static const shoulders = 'shoulders';
  static const chest     = 'chest';
  static const back      = 'back';
  static const hips      = 'hips';
  static const legs      = 'legs';
  static const fullBody  = 'full_body';

  static const all = [neck, shoulders, chest, back, hips, legs, fullBody];

  static String label(String cat) => switch (cat) {
    neck      => 'Cuello',
    shoulders => 'Hombros',
    chest     => 'Pecho',
    back      => 'Espalda',
    hips      => 'Caderas',
    legs      => 'Piernas',
    fullBody  => 'Cuerpo completo',
    _         => cat,
  };
}

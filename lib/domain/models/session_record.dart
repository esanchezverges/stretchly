class StretchRecord {
  final String name;
  final int durationSeconds;
  final String? feedback; // 'easy' | 'ok' | 'hard' | 'skipped'

  const StretchRecord({
    required this.name,
    required this.durationSeconds,
    this.feedback,
  });
}

class SessionRecord {
  final int? id;
  final DateTime date;
  final int durationSeconds;
  final int streakDay;
  final List<StretchRecord> stretches;

  const SessionRecord({
    this.id,
    required this.date,
    required this.durationSeconds,
    required this.streakDay,
    required this.stretches,
  });
}

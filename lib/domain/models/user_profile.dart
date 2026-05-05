class UserProfile {
  final int? id;
  final String name;
  final String level; // 'beginner' | 'intermediate' | 'advanced'
  final List<String> focusAreas;

  const UserProfile({
    this.id,
    required this.name,
    required this.level,
    required this.focusAreas,
  });

  UserProfile copyWith({
    String? name,
    String? level,
    List<String>? focusAreas,
  }) =>
      UserProfile(
        id: id,
        name: name ?? this.name,
        level: level ?? this.level,
        focusAreas: focusAreas ?? this.focusAreas,
      );
}

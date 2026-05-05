class AppSettings {
  final int durationMinutes;
  final String intensity; // 'gentle' | 'moderate' | 'deep'
  final bool dailyReminder;
  final bool streakProtection;
  final bool postWorkoutPrompt;

  const AppSettings({
    this.durationMinutes = 10,
    this.intensity = 'moderate',
    this.dailyReminder = true,
    this.streakProtection = true,
    this.postWorkoutPrompt = false,
  });

  AppSettings copyWith({
    int? durationMinutes,
    String? intensity,
    bool? dailyReminder,
    bool? streakProtection,
    bool? postWorkoutPrompt,
  }) =>
      AppSettings(
        durationMinutes: durationMinutes ?? this.durationMinutes,
        intensity: intensity ?? this.intensity,
        dailyReminder: dailyReminder ?? this.dailyReminder,
        streakProtection: streakProtection ?? this.streakProtection,
        postWorkoutPrompt: postWorkoutPrompt ?? this.postWorkoutPrompt,
      );
}

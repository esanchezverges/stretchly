import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/session_record.dart';
import '../../domain/models/stretch.dart';
import '../../providers/providers.dart';

class SessionFeedbackScreen extends ConsumerStatefulWidget {
  const SessionFeedbackScreen({
    super.key,
    required this.stretches,
    required this.startTime,
  });

  final List<Stretch> stretches;
  final DateTime startTime;

  @override
  ConsumerState<SessionFeedbackScreen> createState() =>
      _SessionFeedbackScreenState();
}

class _SessionFeedbackScreenState
    extends ConsumerState<SessionFeedbackScreen> {
  String? _mood; // 'easy' | 'ok' | 'hard'
  bool _saving = false;

  static const _bg = Color(0xFF111111);
  static const _green = Color(0xFF4A7C59);

  int get _durationSeconds =>
      DateTime.now().difference(widget.startTime).inSeconds;

  Future<void> _save() async {
    setState(() => _saving = true);

    try {
      final last = await ref.read(sessionQueriesProvider).getLastSession();
      final int newStreak;
      if (last == null) {
        newStreak = 1;
      } else {
        final diff = DateTime.now().difference(last.date).inDays;
        if (diff == 0) {
          newStreak = last.streakDay;
        } else if (diff == 1) {
          newStreak = last.streakDay + 1;
        } else {
          newStreak = 1;
        }
      }

      final session = SessionRecord(
        date: widget.startTime,
        durationSeconds: _durationSeconds,
        streakDay: newStreak,
        stretches: widget.stretches
            .map((s) => StretchRecord(
                  name: s.name,
                  durationSeconds: s.totalSeconds,
                  feedback: _mood,
                ))
            .toList(),
      );

      await ref.read(sessionCommandsProvider).saveSession(session);
      ref.invalidate(lastSessionProvider);
      ref.invalidate(currentStreakProvider);
      ref.invalidate(sessionCountProvider);

      if (mounted) {
        // Pop all the way back to HomeScreen
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    } catch (e) {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mins = (_durationSeconds / 60).ceil();
    final count = widget.stretches.length;

    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),

              // ── Celebration ──────────────────────────────────────────
              const Text('🎉', style: TextStyle(fontSize: 64)),
              const SizedBox(height: 16),
              const Text(
                '¡Rutina completada!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),

              // ── Stats row ────────────────────────────────────────────
              _buildStatsRow(mins, count),
              const Spacer(),

              // ── Mood picker ──────────────────────────────────────────
              Text(
                '¿Cómo te has sentido?',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 12,
                children: [
                  _MoodButton(
                    emoji: '😌',
                    label: 'Fácil',
                    value: 'easy',
                    selected: _mood == 'easy',
                    onTap: () => setState(() => _mood = 'easy'),
                  ),
                  _MoodButton(
                    emoji: '👍',
                    label: 'OK',
                    value: 'ok',
                    selected: _mood == 'ok',
                    onTap: () => setState(() => _mood = 'ok'),
                  ),
                  _MoodButton(
                    emoji: '🔥',
                    label: 'Intenso',
                    value: 'hard',
                    selected: _mood == 'hard',
                    onTap: () => setState(() => _mood = 'hard'),
                  ),
                ],
              ),

              const Spacer(),

              // ── Save button ──────────────────────────────────────────
              FilledButton(
                onPressed: _saving ? null : _save,
                style: FilledButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  backgroundColor: _green,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: _saving
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Guardar y salir'),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsRow(int mins, int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _StatChip(
          value: '${ref.watch(currentStreakProvider).valueOrNull ?? 1} 🔥',
          label: 'Racha',
        ),
        _StatChip(value: '$mins min', label: 'Duración'),
        _StatChip(value: '$count', label: 'Estiramientos'),
      ],
    );
  }
}

// ── Widgets ───────────────────────────────────────────────────────────────────

class _StatChip extends StatelessWidget {
  const _StatChip({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12),
        ),
      ],
    );
  }
}

class _MoodButton extends StatelessWidget {
  const _MoodButton({
    required this.emoji,
    required this.label,
    required this.value,
    required this.selected,
    required this.onTap,
  });

  final String emoji;
  final String label;
  final String value;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 96,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF4A7C59)
              : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? const Color(0xFF4A7C59) : Colors.white24,
            width: selected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                color: selected ? Colors.white : Colors.white60,
                fontSize: 13,
                fontWeight:
                    selected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

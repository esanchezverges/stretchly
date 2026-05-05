import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  String _duration = '10m';
  String _intensity = 'Moderate';
  bool _dailyReminder = true;
  bool _streakProtection = true;
  bool _postWorkout = false;

  Future<void> _logout() async {
    await ref.read(sharedPreferencesProvider).remove('auth_user_id');
    ref.read(currentUserIdProvider.notifier).state = null;
    if (mounted) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profile = ref.watch(currentUserProfileProvider);
    final streak = ref.watch(currentStreakProvider);
    final count = ref.watch(sessionCountProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _ProfileHeader(
            theme: theme,
            name: profile.valueOrNull?.name ?? '…',
            level: _displayLevel(profile.valueOrNull?.level),
            focusAreas: profile.valueOrNull?.focusAreas ?? [],
            streak: streak.valueOrNull ?? 0,
            sessionCount: count.valueOrNull ?? 0,
            onLogout: _logout,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionLabel('Session defaults'),
                  _SegmentedRow(
                    label: 'Duration',
                    options: const ['5m', '10m', '15m', '20m'],
                    selected: _duration,
                    onChanged: (v) => setState(() => _duration = v),
                    theme: theme,
                  ),
                  _SegmentedRow(
                    label: 'Intensity',
                    options: const ['Gentle', 'Moderate', 'Deep'],
                    selected: _intensity,
                    onChanged: (v) => setState(() => _intensity = v),
                    theme: theme,
                  ),
                  const SizedBox(height: 20),
                  _SectionLabel('Focus areas'),
                  _FocusAreaChips(
                    initial: profile.valueOrNull?.focusAreas ?? [],
                  ),
                  const SizedBox(height: 20),
                  _SectionLabel('Reminders'),
                  _ToggleRow(
                    label: 'Daily reminder',
                    subtitle: 'Nudge me to stretch',
                    value: _dailyReminder,
                    onChanged: (v) => setState(() => _dailyReminder = v),
                  ),
                  _ToggleRow(
                    label: 'Streak protection',
                    subtitle: 'Alert if voy a romper el streak',
                    value: _streakProtection,
                    onChanged: (v) => setState(() => _streakProtection = v),
                  ),
                  _ToggleRow(
                    label: 'Post-workout prompt',
                    subtitle: 'Recordarme después de entrenar',
                    value: _postWorkout,
                    onChanged: (v) => setState(() => _postWorkout = v),
                  ),
                  const SizedBox(height: 20),
                  _SectionLabel('History'),
                  const SizedBox(height: 8),
                  Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: null,
                          icon: const Icon(Icons.history),
                          label: const Text('All Sessions'),
                        ),
                      ),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: null,
                          icon: const Icon(Icons.replay),
                          label: const Text('Replay Last'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _displayLevel(String? level) {
    switch (level) {
      case 'intermediate': return 'Intermediate';
      case 'advanced':     return 'Advanced';
      default:             return 'Beginner';
    }
  }
}

// ── Header ────────────────────────────────────────────────────────────────────

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({
    required this.theme,
    required this.name,
    required this.level,
    required this.focusAreas,
    required this.streak,
    required this.sessionCount,
    required this.onLogout,
  });

  final ThemeData theme;
  final String name;
  final String level;
  final List<String> focusAreas;
  final int streak;
  final int sessionCount;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 210,
      pinned: true,
      backgroundColor: const Color(0xFF111111),
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          tooltip: 'Cerrar sesión',
          icon: const Icon(Icons.logout, color: Colors.white70),
          onPressed: onLogout,
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 48, 18, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 26,
                      backgroundColor: Colors.white12,
                      child: Icon(Icons.person, color: Colors.white38, size: 30),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Wrap(
                            spacing: 6,
                            children: [
                              _HeaderChip(level),
                              if (focusAreas.isNotEmpty)
                                _HeaderChip(focusAreas.first),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _StatItem(value: '$sessionCount', label: 'Sessions'),
                    _StatItem(
                      value: streak > 0 ? '$streak 🔥' : '$streak',
                      label: 'Streak',
                    ),
                    const _StatItem(value: '—', label: 'Avg session'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderChip extends StatelessWidget {
  const _HeaderChip(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white30),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(label,
            style: const TextStyle(color: Colors.white54, fontSize: 12)),
      ],
    );
  }
}

// ── Reusable section widgets ───────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 6),
      child: Text(
        label.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              letterSpacing: 1.2,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
      ),
    );
  }
}

class _SegmentedRow extends StatelessWidget {
  const _SegmentedRow({
    required this.label,
    required this.options,
    required this.selected,
    required this.onChanged,
    required this.theme,
  });

  final String label;
  final List<String> options;
  final String selected;
  final ValueChanged<String> onChanged;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(label, style: theme.textTheme.bodyMedium),
          ),
          Expanded(
            child: SegmentedButton<String>(
              segments: options
                  .map((o) => ButtonSegment(value: o, label: Text(o)))
                  .toList(),
              selected: {selected},
              onSelectionChanged: (s) => onChanged(s.first),
              style: const ButtonStyle(
                visualDensity: VisualDensity.compact,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FocusAreaChips extends StatefulWidget {
  const _FocusAreaChips({required this.initial});
  final List<String> initial;

  @override
  State<_FocusAreaChips> createState() => _FocusAreaChipsState();
}

class _FocusAreaChipsState extends State<_FocusAreaChips> {
  late List<String> _areas;

  @override
  void initState() {
    super.initState();
    _areas = List<String>.from(widget.initial);
  }

  @override
  void didUpdateWidget(_FocusAreaChips old) {
    super.didUpdateWidget(old);
    if (old.initial != widget.initial) {
      _areas = List<String>.from(widget.initial);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Wrap(
        spacing: 8,
        runSpacing: 4,
        children: [
          ..._areas.map(
            (a) => Chip(
              label: Text(a),
              deleteIcon: const Icon(Icons.close, size: 16),
              onDeleted: () => setState(() => _areas.remove(a)),
            ),
          ),
          ActionChip(
            avatar: const Icon(Icons.add, size: 16),
            label: const Text('Add'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.label,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile.adaptive(
      contentPadding: EdgeInsets.zero,
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
    );
  }
}

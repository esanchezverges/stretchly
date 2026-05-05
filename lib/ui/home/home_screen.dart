import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/session_record.dart';
import '../../domain/models/stretch_catalog.dart';
import '../../providers/providers.dart';
import '../profile/profile_screen.dart';
import '../routine/routine_preview_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'stretchly',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const Spacer(),
            _FigurePlaceholder(colors: colors),
            const SizedBox(height: 16),
            Text(
              'Ready to stretch?',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RoutinePreviewScreen(
                    stretches: StretchCatalog.random(),
                  ),
                ),
              ),
              icon: const Icon(Icons.play_arrow),
              label: const Text('Generate Routine'),
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            _LastSessionCard(ref.watch(lastSessionProvider)),
            const Spacer(),
            const _QuickFilterRow(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// ── Widgets ───────────────────────────────────────────────────────────────────

class _FigurePlaceholder extends StatelessWidget {
  const _FigurePlaceholder({required this.colors});
  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 60,
      backgroundColor: colors.surfaceContainerHighest,
      child: Icon(Icons.accessibility_new, size: 52, color: colors.onSurfaceVariant),
    );
  }
}

class _LastSessionCard extends StatelessWidget {
  const _LastSessionCard(this.asyncSession);
  final AsyncValue<SessionRecord?> asyncSession;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return asyncSession.when(
      loading: () => const SizedBox(height: 64),
      error: (_, __) => const SizedBox.shrink(),
      data: (session) {
        if (session == null) return const SizedBox.shrink();

        final mins = (session.durationSeconds / 60).ceil();
        final count = session.stretches.length;
        final label = _formatDate(session.date);

        return Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Last session',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$count stretches · $mins min',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Chip(label: Text(label)),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    final diff = DateTime.now().difference(date).inDays;
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    return '$diff days ago';
  }
}

class _QuickFilterRow extends StatelessWidget {
  const _QuickFilterRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: null,
            child: const Text('Duration'),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: OutlinedButton(
            onPressed: null,
            child: const Text('Focus Area'),
          ),
        ),
      ],
    );
  }
}

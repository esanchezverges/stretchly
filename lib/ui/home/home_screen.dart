import 'package:flutter/material.dart';
import '../../domain/models/stretch_catalog.dart';
import '../profile/profile_screen.dart';
import '../routine/routine_preview_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            _LastSessionCard(theme: theme, colors: colors),
            const Spacer(),
            _QuickFilterRow(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _FigurePlaceholder extends StatelessWidget {
  const _FigurePlaceholder({required this.colors});

  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 60,
      backgroundColor: colors.surfaceContainerHighest,
      child: Icon(
        Icons.accessibility_new,
        size: 52,
        color: colors.onSurfaceVariant,
      ),
    );
  }
}

class _LastSessionCard extends StatelessWidget {
  const _LastSessionCard({required this.theme, required this.colors});

  final ThemeData theme;
  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
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
                    'Full Body · 8 min',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Chip(label: const Text('Yesterday')),
          ],
        ),
      ),
    );
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

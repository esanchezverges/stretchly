import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/stretch.dart';
import '../../domain/models/stretch_catalog.dart';
import '../../providers/providers.dart';
import '../session/session_screen.dart';
import 'edit_routine_screen.dart';

class RoutinePreviewScreen extends ConsumerStatefulWidget {
  const RoutinePreviewScreen({super.key, required this.stretches});

  final List<Stretch> stretches;

  @override
  ConsumerState<RoutinePreviewScreen> createState() =>
      _RoutinePreviewScreenState();
}

class _RoutinePreviewScreenState extends ConsumerState<RoutinePreviewScreen> {
  late List<Stretch> _stretches;
  late Set<String> _activeCategories;

  @override
  void initState() {
    super.initState();
    _stretches = widget.stretches;
    // Default filter = user's focus areas (mapped to category keys)
    final focusAreas = ref.read(currentUserProfileProvider).valueOrNull?.focusAreas ?? [];
    _activeCategories = focusAreas.isNotEmpty
        ? _matchedCategories(focusAreas)
        : {};
  }

  /// Maps user focus area strings to the closest StretchCategory keys
  Set<String> _matchedCategories(List<String> focusAreas) {
    return StretchCategory.all.where((cat) {
      return focusAreas.any((fa) {
        final f = fa.toLowerCase();
        return cat.contains(f) || f.contains(cat);
      });
    }).toSet();
  }

  int get _totalMinutes =>
      (_stretches.fold(0, (s, e) => s + e.totalSeconds) / 60).ceil();

  void _regenerate() => setState(() {
        _stretches = StretchCatalog.random(
          focusAreas: _activeCategories.toList(),
        );
      });

  Future<void> _openEdit() async {
    final result = await Navigator.push<List<Stretch>>(
      context,
      MaterialPageRoute(
        builder: (_) => EditRoutineScreen(stretches: _stretches),
      ),
    );
    if (result != null) setState(() => _stretches = result);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Routine'),
        actions: [
          TextButton(onPressed: _openEdit, child: const Text('Edit')),
        ],
      ),
      body: Column(
        children: [
          _StatsRow(count: _stretches.length, minutes: _totalMinutes),
          const Divider(height: 1),
          _CategoryFilterRow(
            active: _activeCategories,
            onToggle: (cat) => setState(() {
              if (_activeCategories.contains(cat)) {
                _activeCategories.remove(cat);
              } else {
                _activeCategories.add(cat);
              }
            }),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.separated(
              itemCount: _stretches.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, i) => _StretchTile(
                index: i,
                stretch: _stretches[i],
                colors: colors,
              ),
            ),
          ),
          _BottomActions(
            stretches: _stretches,
            onRegenerate: _regenerate,
          ),
        ],
      ),
    );
  }
}

// ── Widgets ───────────────────────────────────────────────────────────────────

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.count, required this.minutes});
  final int count;
  final int minutes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        spacing: 8,
        children: [
          Chip(label: Text('$minutes min')),
          Chip(label: Text('$count stretches')),
        ],
      ),
    );
  }
}

class _CategoryFilterRow extends StatelessWidget {
  const _CategoryFilterRow({required this.active, required this.onToggle});
  final Set<String> active;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        children: StretchCategory.all.map((cat) {
          final selected = active.contains(cat);
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(StretchCategory.label(cat)),
              selected: selected,
              onSelected: (_) => onToggle(cat),
              selectedColor: colors.primaryContainer,
              checkmarkColor: colors.onPrimaryContainer,
              labelStyle: TextStyle(
                color: selected
                    ? colors.onPrimaryContainer
                    : colors.onSurfaceVariant,
                fontSize: 12,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _StretchTile extends StatelessWidget {
  const _StretchTile({
    required this.index,
    required this.stretch,
    required this.colors,
  });
  final int index;
  final Stretch stretch;
  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: colors.surfaceContainerHighest,
        foregroundColor: colors.onSurfaceVariant,
        child: Text('${index + 1}'),
      ),
      title: Text(stretch.name,
          style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            stretch.description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12, color: colors.onSurfaceVariant),
          ),
          const SizedBox(height: 2),
          Row(
            spacing: 6,
            children: [
              Text(stretch.duration,
                  style: TextStyle(
                      fontSize: 12, color: colors.onSurfaceVariant)),
              _CategoryBadge(stretch.category, colors: colors),
            ],
          ),
        ],
      ),
      isThreeLine: true,
    );
  }
}

class _CategoryBadge extends StatelessWidget {
  const _CategoryBadge(this.category, {required this.colors});
  final String category;
  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      decoration: BoxDecoration(
        color: colors.secondaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        StretchCategory.label(category),
        style: TextStyle(
          fontSize: 10,
          color: colors.onSecondaryContainer,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _BottomActions extends StatelessWidget {
  const _BottomActions({required this.stretches, required this.onRegenerate});
  final List<Stretch> stretches;
  final VoidCallback onRegenerate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      child: Column(
        spacing: 10,
        children: [
          FilledButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SessionScreen(stretches: stretches),
              ),
            ),
            icon: const Icon(Icons.play_arrow),
            label: const Text('Start Routine'),
            style: FilledButton.styleFrom(
              minimumSize: const Size(double.infinity, 52),
            ),
          ),
          OutlinedButton.icon(
            onPressed: onRegenerate,
            icon: const Icon(Icons.refresh),
            label: const Text('Regenerate'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 52),
            ),
          ),
        ],
      ),
    );
  }
}

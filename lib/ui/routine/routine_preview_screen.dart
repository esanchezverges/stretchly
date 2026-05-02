import 'package:flutter/material.dart';
import '../../domain/models/stretch.dart';
import '../../domain/models/stretch_catalog.dart';
import '../session/session_screen.dart';
import 'edit_routine_screen.dart';

class RoutinePreviewScreen extends StatefulWidget {
  const RoutinePreviewScreen({super.key, required this.stretches});

  final List<Stretch> stretches;

  @override
  State<RoutinePreviewScreen> createState() => _RoutinePreviewScreenState();
}

class _RoutinePreviewScreenState extends State<RoutinePreviewScreen> {
  late List<Stretch> _stretches;

  @override
  void initState() {
    super.initState();
    _stretches = widget.stretches;
  }

  int get _totalMinutes =>
      (_stretches.fold(0, (s, e) => s + e.totalSeconds) / 60).ceil();

  void _regenerate() => setState(() => _stretches = StretchCatalog.random());

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
          _TagsRow(count: _stretches.length, minutes: _totalMinutes),
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

class _TagsRow extends StatelessWidget {
  const _TagsRow({required this.count, required this.minutes});

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

class _StretchTile extends StatelessWidget {
  const _StretchTile({required this.index, required this.stretch, required this.colors});

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
      title: Text(stretch.name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(stretch.duration),
      trailing: const Icon(Icons.more_vert),
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

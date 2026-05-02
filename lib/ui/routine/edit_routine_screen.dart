import 'package:flutter/material.dart';
import '../../domain/models/stretch.dart';

class EditRoutineScreen extends StatefulWidget {
  const EditRoutineScreen({super.key, required this.stretches});

  final List<Stretch> stretches;

  @override
  State<EditRoutineScreen> createState() => _EditRoutineScreenState();
}

class _EditRoutineScreenState extends State<EditRoutineScreen> {
  late List<Stretch> _stretches;

  @override
  void initState() {
    super.initState();
    _stretches = [...widget.stretches];
  }

  int get _totalMinutes =>
      (_stretches.fold(0, (s, e) => s + e.totalSeconds) / 60).ceil();

  void _reorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex--;
      _stretches.insert(newIndex, _stretches.removeAt(oldIndex));
    });
  }

  void _remove(int index) => setState(() => _stretches.removeAt(index));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        leadingWidth: 80,
        title: const Text('Edit Routine'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, _stretches),
            child: const Text('Done'),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: colors.surfaceContainerLow,
            child: Text(
              'Arrastra ☰ para reordenar · toca × para eliminar',
              style: theme.textTheme.labelSmall?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: ReorderableListView.builder(
              buildDefaultDragHandles: false,
              itemCount: _stretches.length,
              onReorder: _reorder,
              itemBuilder: (context, i) {
                final s = _stretches[i];
                return ListTile(
                  key: ValueKey('$i-${s.name}'),
                  leading: ReorderableDragStartListener(
                    index: i,
                    child: const Icon(Icons.drag_handle),
                  ),
                  title: Text(
                    s.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(s.duration),
                  trailing: IconButton(
                    icon: Icon(Icons.cancel_outlined, color: colors.error),
                    onPressed: () => _remove(i),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
            child: Column(
              spacing: 8,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${_stretches.length} estiramientos',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      '~$_totalMinutes min',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                FilledButton.icon(
                  onPressed: () => Navigator.pop(context, _stretches),
                  icon: const Icon(Icons.check),
                  label: const Text('Guardar rutina'),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(double.infinity, 52),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

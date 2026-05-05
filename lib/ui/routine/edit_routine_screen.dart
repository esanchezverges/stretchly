import 'package:flutter/material.dart';
import '../../domain/models/stretch.dart';
import '../../domain/models/stretch_catalog.dart';

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

  Future<void> _openPicker() async {
    final added = await showModalBottomSheet<List<Stretch>>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => const _StretchPickerSheet(),
    );
    if (added != null && added.isNotEmpty) {
      setState(() => _stretches.addAll(added));
    }
  }

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
              footer: _AddStretchButton(onTap: _openPicker),
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

// ── Add button (footer of the list) ──────────────────────────────────────────

class _AddStretchButton extends StatelessWidget {
  const _AddStretchButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(Icons.add_circle_outline, color: colors.primary),
            const SizedBox(width: 12),
            Text(
              'Add stretch',
              style: TextStyle(
                color: colors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Picker bottom sheet ───────────────────────────────────────────────────────

class _StretchPickerSheet extends StatefulWidget {
  const _StretchPickerSheet();

  @override
  State<_StretchPickerSheet> createState() => _StretchPickerSheetState();
}

class _StretchPickerSheetState extends State<_StretchPickerSheet> {
  final _searchCtrl = TextEditingController();
  String _query = '';
  String? _activeCategory; // null = all
  final Set<int> _selectedIndexes = {}; // indexes into StretchCatalog.all

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<({int index, Stretch stretch})> get _filtered {
    return StretchCatalog.all
        .asMap()
        .entries
        .where((e) {
          final s = e.value;
          final matchesQuery = _query.isEmpty ||
              s.name.toLowerCase().contains(_query.toLowerCase());
          final matchesCategory =
              _activeCategory == null || s.category == _activeCategory;
          return matchesQuery && matchesCategory;
        })
        .map((e) => (index: e.key, stretch: e.value))
        .toList();
  }

  void _confirm() {
    final selected = _selectedIndexes
        .map((i) => StretchCatalog.all[i])
        .toList();
    Navigator.pop(context, selected);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final filtered = _filtered;
    final count = _selectedIndexes.length;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, scrollController) => Column(
        children: [
          // ── Handle ──────────────────────────────────────────────────────
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 4),
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: colors.onSurfaceVariant.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // ── Header ──────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Row(
              children: [
                Text(
                  'Añadir estiramientos',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          // ── Search ──────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchCtrl,
              onChanged: (v) => setState(() => _query = v),
              decoration: InputDecoration(
                hintText: 'Buscar ejercicio…',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchCtrl.clear();
                          setState(() => _query = '');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),

          // ── Category filter ──────────────────────────────────────────────
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: const Text('Todos'),
                    selected: _activeCategory == null,
                    onSelected: (_) => setState(() => _activeCategory = null),
                  ),
                ),
                ...StretchCategory.all.map((cat) {
                  final selected = _activeCategory == cat;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(StretchCategory.label(cat)),
                      selected: selected,
                      onSelected: (_) => setState(() =>
                          _activeCategory = selected ? null : cat),
                    ),
                  );
                }),
              ],
            ),
          ),

          const Divider(height: 1),

          // ── List ─────────────────────────────────────────────────────────
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Text(
                      'Sin resultados',
                      style: TextStyle(color: colors.onSurfaceVariant),
                    ),
                  )
                : ListView.builder(
                    controller: scrollController,
                    itemCount: filtered.length,
                    itemBuilder: (_, i) {
                      final item = filtered[i];
                      final isSelected =
                          _selectedIndexes.contains(item.index);
                      return CheckboxListTile(
                        value: isSelected,
                        onChanged: (_) => setState(() {
                          if (isSelected) {
                            _selectedIndexes.remove(item.index);
                          } else {
                            _selectedIndexes.add(item.index);
                          }
                        }),
                        title: Text(
                          item.stretch.name,
                          style:
                              const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Row(
                          spacing: 6,
                          children: [
                            Text(item.stretch.duration,
                                style: const TextStyle(fontSize: 12)),
                            _CategoryBadge(
                                item.stretch.category, colors: colors),
                          ],
                        ),
                        secondary: isSelected
                            ? Icon(Icons.check_circle,
                                color: colors.primary)
                            : const Icon(Icons.circle_outlined,
                                color: Colors.transparent),
                        controlAffinity: ListTileControlAffinity.leading,
                      );
                    },
                  ),
          ),

          // ── Confirm button ────────────────────────────────────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: FilledButton(
                onPressed: count > 0 ? _confirm : null,
                style: FilledButton.styleFrom(
                  minimumSize: const Size(double.infinity, 52),
                ),
                child: Text(
                  count > 0 ? 'Añadir ($count)' : 'Añadir',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Shared badge ──────────────────────────────────────────────────────────────

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

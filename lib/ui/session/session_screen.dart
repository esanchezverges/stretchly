import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/stretch.dart';
import '../../services/sound_service.dart';
import 'session_feedback_screen.dart';

class SessionScreen extends ConsumerStatefulWidget {
  const SessionScreen({super.key, required this.stretches});

  final List<Stretch> stretches;

  @override
  ConsumerState<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends ConsumerState<SessionScreen> {
  int _index = 0;
  late int _secondsLeft;
  bool _isPaused = false;
  Timer? _timer;
  final _sound = SoundService();
  late final DateTime _startTime;

  static const _bg = Color(0xFF111111);
  static const _green = Color(0xFF4A7C59);

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();
    _secondsLeft = _parseDuration(widget.stretches[0].duration);
    _sound.init().then((_) => _startTimer());
  }

  @override
  void dispose() {
    _timer?.cancel();
    _sound.dispose();
    super.dispose();
  }

  int _parseDuration(String duration) {
    final match = RegExp(r'(\d+)s').firstMatch(duration);
    return match != null ? int.parse(match.group(1)!) : 30;
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_isPaused) return;
      if (_secondsLeft > 0) {
        setState(() => _secondsLeft--);
        if (_secondsLeft <= 3 && _secondsLeft > 0) _sound.playTick();
      } else {
        _sound.playPling();
        _goNext();
      }
    });
  }

  Future<void> _goNext() async {
    if (_index < widget.stretches.length - 1) {
      setState(() {
        _index++;
        _secondsLeft = _parseDuration(widget.stretches[_index].duration);
      });
    } else {
      _timer?.cancel();
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => SessionFeedbackScreen(
              stretches: widget.stretches,
              startTime: _startTime,
            ),
          ),
        );
      }
    }
  }

  void _goPrev() {
    if (_index > 0) {
      setState(() {
        _index--;
        _secondsLeft = _parseDuration(widget.stretches[_index].duration);
      });
    }
  }

  void _togglePause() => setState(() => _isPaused = !_isPaused);

  @override
  Widget build(BuildContext context) {
    final stretch = widget.stretches[_index];
    final total = widget.stretches.length;
    final totalSecs = _parseDuration(stretch.duration);
    final progress = 1 - (_secondsLeft / totalSecs).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              _TopBar(
                index: _index,
                total: total,
                onClose: () {
                  _timer?.cancel();
                  Navigator.pop(context);
                },
              ),
              const Spacer(),
              _Illustration(),
              const SizedBox(height: 24),
              Text(
                stretch.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                stretch.duration,
                style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 14),
              ),
              const SizedBox(height: 24),
              Text(
                ':${_secondsLeft.toString().padLeft(2, '0')}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 88,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  backgroundColor: Colors.white12,
                  valueColor: const AlwaysStoppedAnimation<Color>(_green),
                ),
              ),
              const Spacer(),
              _Controls(
                isPaused: _isPaused,
                canGoPrev: _index > 0,
                onPrev: _goPrev,
                onNext: _goNext,
                onTogglePause: _togglePause,
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: _goNext,
                child: Text(
                  'Skip this stretch',
                  style: TextStyle(color: Colors.white.withOpacity(0.4)),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Sub-widgets (unchanged) ───────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  const _TopBar({required this.index, required this.total, required this.onClose});

  final int index;
  final int total;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white54),
            onPressed: onClose,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 6,
              children: List.generate(
                total,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: i == index ? 18 : 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: i <= index ? const Color(0xFF4A7C59) : Colors.white24,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 48,
            child: Text(
              '${index + 1} / $total',
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

class _Illustration extends StatelessWidget {
  const _Illustration();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: const Icon(Icons.accessibility_new, size: 72, color: Colors.white24),
    );
  }
}

class _Controls extends StatelessWidget {
  const _Controls({
    required this.isPaused,
    required this.canGoPrev,
    required this.onPrev,
    required this.onNext,
    required this.onTogglePause,
  });

  final bool isPaused;
  final bool canGoPrev;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final VoidCallback onTogglePause;

  static const _style = ButtonStyle(
    foregroundColor: WidgetStatePropertyAll(Colors.white),
    side: WidgetStatePropertyAll(BorderSide(color: Colors.white24)),
    padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 16)),
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: canGoPrev ? onPrev : null,
            style: _style,
            child: const Icon(Icons.skip_previous),
          ),
        ),
        Expanded(
          child: OutlinedButton(
            onPressed: onTogglePause,
            style: _style,
            child: Icon(isPaused ? Icons.play_arrow : Icons.pause),
          ),
        ),
        Expanded(
          child: OutlinedButton(
            onPressed: onNext,
            style: _style,
            child: const Icon(Icons.skip_next),
          ),
        ),
      ],
    );
  }
}

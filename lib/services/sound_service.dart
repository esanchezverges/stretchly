import 'package:audioplayers/audioplayers.dart';

class SoundService {
  final _tick = AudioPlayer();
  final _pling = AudioPlayer();

  Future<void> init() async {
    await _tick.setSource(AssetSource('sounds/tick.wav'));
    await _pling.setSource(AssetSource('sounds/pling.wav'));
  }

  Future<void> playTick() => _tick.resume();
  Future<void> playPling() => _pling.resume();

  void dispose() {
    _tick.dispose();
    _pling.dispose();
  }
}

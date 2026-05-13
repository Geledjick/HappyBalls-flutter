import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:riverpod/riverpod.dart';

class Music extends ChangeNotifier {
  bool _state = true;

  final AudioPlayer _player = AudioPlayer();

  bool getState() {
    return _state;
  }

  AudioPlayer getPlayer() {
    return _player;
  }

  void changeState() {
    _state = !_state;

    if (_state) {
      _player.play();
    } else {
      _player.pause();
    }

    notifyListeners();
  }

  Future<void> playLoopAsset(String assetPath, {double volume = 1.0}) async {
    await _player.setAsset(assetPath, preload: true);
    _player.setLoopMode(LoopMode.one);
    _player.setVolume(volume);
    _player.play();
  }

  Future<void> dispose() async {
    await _player.dispose();
  }
}

final musicProvider = Provider<Music>((ref) => Music());
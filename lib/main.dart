import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Music.dart';
import 'MenuScreen.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp()
    )
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final music = ref.read(musicProvider);
    music.playLoopAsset('background_music.mp3');

    return MaterialApp(home: MenuScreen());
  }
}
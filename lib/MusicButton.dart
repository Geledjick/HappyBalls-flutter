import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Music.dart';

class MusicButton extends ConsumerStatefulWidget {
  @override
  ConsumerState<MusicButton> createState() => _MusicButtonState();
}

class _MusicButtonState extends ConsumerState<MusicButton> {
  @override
  Widget build(BuildContext context) {
    final music = ref.read(musicProvider);

    return ListenableBuilder(
      listenable: music,
      builder: (context, child) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle
          ),
          child: SizedBox(
            child: IconButton(
              icon: Icon(music.getState() ? Icons.music_off_rounded : Icons.music_note_rounded),
              onPressed: () {
                music.changeState();
              },
            ),
          ),
        );
      }
    );
  }
}
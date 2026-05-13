import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poster/Music.dart';
import 'package:poster/MusicButton.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  double volume = 0.5;

  @override
  Widget build(BuildContext context) {
    final music = ref.read(musicProvider);

    return Scaffold(
      body: Center(
        child: Column(
          spacing: 4.0,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                MusicButton(),

                Slider(
                  value: volume,
                  min: 0.0,
                  max: 1.0,
                  divisions: 100,
                  label: '${(volume * 100).round()}%',
                  onChanged: (v) {
                    setState(() {
                      volume = v;
                      music.getPlayer().setVolume(volume);
                    });
                  },
                )
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Back")
            )
          ],
        ),
      ),
    );
  }
}
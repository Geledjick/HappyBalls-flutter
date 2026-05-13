import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poster/MusicButton.dart';

import 'Music.dart';
import 'GameScreen.dart';
import 'SettingsScreen.dart';
import 'CloudButton.dart';

class MenuScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<MenuScreen> createState() => _MenuState();
}

class _MenuState extends ConsumerState<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    final music = ref.read(musicProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          spacing: 4.0,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),

            CloudButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => GameScreen()));
              },
              child: Text("Play")
            ),
            
            CloudButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
              },
              child: Text("Settings")
            ),

            CloudButton(
              onPressed: () {
                music.dispose();
                exit(0);
              },
              child: Text("Exit")
            ),
          
            Spacer(),

            MusicButton(),

            Spacer()
          ],
        ),
      ),
    );
  }
}
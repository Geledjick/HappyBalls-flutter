import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'DigitalScore.dart';
import 'Ball.dart';

class ScoreBar extends StatelessWidget {
  const ScoreBar({super.key, required this.score, required this.grabedBall, required this.combo});
  
  final int score;
  final int combo;
  final Ball grabedBall;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: const Color.fromARGB(255, 100, 100, 100),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              size: 48.0,
              Icons.arrow_left
            )
          ),
          Spacer(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: grabedBall.color,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Spacer(),
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.black
            ),
            child: DigitalScore(
              value: score,
              digits: 6,
              digitWidth: 28,
              digitHeight: 56,
              onColor: Colors.greenAccent,
            ),
          ),
          Spacer(),
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.black
            ),
            child: DigitalScore(
              value: combo,
              digits: 2,
              digitWidth: 28,
              digitHeight: 56,
              onColor: Colors.redAccent,
            ),
          ),
          Spacer()
        ],
      ),
    ); 
  }
}
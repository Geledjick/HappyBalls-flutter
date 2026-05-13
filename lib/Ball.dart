import 'package:flutter/material.dart';

class Ball {
  Color color = Colors.transparent;
}

class BallWidget extends StatelessWidget {
  const BallWidget({super.key, required this.ball});

  final Ball ball;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: AnimatedContainer(
        decoration: BoxDecoration(
          color: ball.color,
          shape: BoxShape.circle,
        ),
        duration: const Duration(milliseconds: 250),
        curve: Curves.linear,
      ),
    );
  }
}
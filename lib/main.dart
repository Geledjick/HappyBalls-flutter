import 'package:flutter/material.dart';
import 'game_screen.dart';

void main() {
  runApp(MyApp());
}

var buttonStyle = ButtonStyle(

);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Game with Menu",
      initialRoute: "/",
      routes: {
        "/": (context) => MenuScreen(),
        "/game": (context) => GameScreen(),
      },
    );
  }
}

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              child: Text("Start Game"),
              onPressed: () {
                Navigator.pushNamed(context, "/game");
              },
            ),
            SizedBox(height: 12),
            ElevatedButton(child: Text("Exit"), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}

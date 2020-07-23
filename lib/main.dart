import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:kanban_board/src/app.dart';


void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Kanban board",
    home: AnimatedSplashScreen (
      splash: Image.asset("splsc.jpg"),
      duration: 2700,
      nextScreen: App(),
    ),
  )
  );

}

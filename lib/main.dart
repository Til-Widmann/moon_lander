import 'package:flame/game.dart';

import 'package:flutter/material.dart';

import 'moonLander/gameController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Game game = GameController();
  runApp(game.widget);
}








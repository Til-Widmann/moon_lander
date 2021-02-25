import 'dart:ui';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/flame.dart';
import 'package:flame/game/base_game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';
import 'Input.dart';
import 'SpaceShip.dart';
import 'file:///C:/Users/Til-W/AndroidStudioProjects/moon_lander/lib/moonLander/ColisionDetection.dart';

import 'Landscape.dart';

class GameController extends BaseGame with HasTapableComponents{

  Size size;
  SpaceShip spaceShip;
  GameController() {
    init();
  }

  void init() async{
    Flame.util.setPortrait();
    size = await Flame.util.initialDimensions();
    Input leftThrustButton;
    Input rightThrustButton;
    Input mainThrustButton;
    Input resetButton;
    LandScapeDraw landScapeDraw;
    CollisionDetector collisionDetector;

    add(leftThrustButton = Input(0, size.height - 100,size.width/3 - 10,size.height));
    add(rightThrustButton = Input(size.width/3*2, size.height - 100, size.width, size.height));
    add(mainThrustButton = Input(size.width/3, size.height - 100, size.width/3*2 - 10, size.height));
    add(resetButton = Input(0, 0, 50, 50));
    add(landScapeDraw = LandScapeDraw(size, resetButton));
    collisionDetector = CollisionDetector(landScapeDraw.landscape);
    add(spaceShip = SpaceShip(leftThrustButton, rightThrustButton, mainThrustButton, collisionDetector , resetButton));


  }


  @override
  void resize(Size size) {
    super.resize(size);
    this.size = size;
  }

  @override
  void update(double t) {
    super.update(t);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }
}




import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flutter/material.dart';

class Input extends PositionComponent with Tapable {
  Rect buttonBox;
  bool isPressed = false;
  Paint color = new Paint();

  Input (double left, double top, double right, double bottom){
    buttonBox = new Rect.fromLTRB(left, top, right, bottom);
    color.color = Colors.white10;
  }
  @override
  Rect toRect() => buttonBox;

  @override
  void onTapDown(TapDownDetails details) => isPressed = true;

  @override
  void onTapUp(TapUpDetails details) => isPressed = false;


  @override
  void onTapCancel() => isPressed = false;

  @override
  void render(Canvas c) {
    c.drawRect(buttonBox, color);
  }
}
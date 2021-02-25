import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'file:///C:/Users/Til-W/AndroidStudioProjects/moon_lander/lib/moonLander/gameController.dart';
import 'package:moon_lander/moonLander/Landscape.dart';


class StaticCollisionLine {
  Offset start;
  Offset end;
  double xVec;
  double yVec;

  StaticCollisionLine(this.start, this.end) {
    xVec = end.dx - start.dx;
    yVec = end.dy - start.dy;
  }

  bool isCollidingWithLine(Offset point) {
    var lineHightAtPointX = (point.dx - start.dx)/xVec.abs() * yVec.abs() + start.dy;
    return lineHightAtPointX < point.dy;
  }
}
class CollisionDetector {
  List<StaticCollisionLine> collisionLineList = List();
  StaticCollisionLine currentLine;
  List<Offset> points;

  CollisionDetector(List<Offset> points){
    _initCollisionLineList(points);
  }

  void _initCollisionLineList(List<Offset> points) {
    Offset lastElement;
    points.forEach((element) {
      if(lastElement == null){
        lastElement = element;
      }else{
        collisionLineList.add(StaticCollisionLine(lastElement, element));
        lastElement = element;
      }
    });
    currentLine = collisionLineList.first;
  }

  bool isColliding(Offset point) {
    if(_isOverLine(currentLine, point)){
      return currentLine.isCollidingWithLine(point);
    }
    collisionLineList.forEach((element) {
      if(_isOverLine(element, point)){
        currentLine = element;
        return currentLine.isCollidingWithLine(point);
      }
    });
    return false;
  }

  bool _isOverLine(StaticCollisionLine line, Offset point) {
    return line.start.dx <= point.dx && line.end.dx >= point.dx;
  }
}
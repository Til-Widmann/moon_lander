import 'dart:math';
import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flutter/material.dart';

import 'Input.dart';

class LandScapeCalculator with Resizable{
  int height;
  int detail;
  Size size;

  LandScapeCalculator(this.height, this.detail, this.size){
    generateLandscapePoints();
  }

  Random random = new Random();


  List<Offset> _landScapePoints;

  List<Offset> generateLandscapePoints() {
    _landScapePoints = new List<Offset>();
    _landScapePoints.add(new Offset(0, size.height));
    var padLocationAt = random.nextInt(detail);
    for(int i = 0; i <= detail; i++) {
      if(i != padLocationAt) {
        _landScapePoints.add(_generatePoint(i));
      }else{
        var padEnd = new Offset(size.width/detail*i, _landScapePoints.last.dy);
        _landScapePoints.add(padEnd);
      }
    }
    return _landScapePoints;
  }
  Offset _generatePoint(int i) {
    var x = size.width/detail*i;
    var y = size.height - random.nextInt(height).abs();
    return new Offset(x, y);
  }

}
class LandScapeDraw extends Component{
  List<Offset> landscape;
  Paint color;
  Input resetButton;
  LandScapeCalculator landScapeCalculator;

  LandScapeDraw(Size size, Input resetButton) : super(){
    this.resetButton = resetButton;
    landScapeCalculator = new LandScapeCalculator(200, 20, size);
    landscape = landScapeCalculator._landScapePoints;
    color = Paint();
    color.color = Colors.white;
  }

  @override
  void render(Canvas c) {
    c.drawPoints( PointMode.polygon, landScapeCalculator._landScapePoints, color);
  }
  @override
  void update(double t) {
    if(resetButton.isPressed) landScapeCalculator.generateLandscapePoints();
  }
}
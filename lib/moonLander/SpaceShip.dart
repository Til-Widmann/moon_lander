import 'dart:math';
import 'dart:ui';
import 'package:flame/anchor.dart';
import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/sprite.dart';
import 'file:///C:/Users/Til-W/AndroidStudioProjects/moon_lander/lib/moonLander/ColisionDetection.dart';

import 'Input.dart';

class SpaceShip extends AnimationComponent with Resizable {
  static const int ENGINEPOWER = 75;
  static const int GRAVITY = 5;
  static const int TURNTHRUSTERPOWER = 1;

  double xVel = 70;
  double yVel = 0;

  Input leftThruster;
  Input rightThruster;
  Input mainThruster;
  Input resetButton;
  CollisionDetector collisionDetector;
  Animation firingThrusterAnimation;
  Animation offThrusterAnimation;

  SpaceShip(this.leftThruster, this.rightThruster, this.mainThruster, this.collisionDetector, this.resetButton) : super(50,
      50,
      new Animation.spriteList([0, 1, 2].map((i) =>
      new Sprite('spaceShip_$i.png')).toList() , stepTime: 0.20))
  {
    this.anchor = Anchor.center;
    this.firingThrusterAnimation = super.animation;
    this.offThrusterAnimation = new Animation.spriteList(List.generate(1, (index) => new Sprite('spaceShipOff.png')));
  }

  @override
  Animation get animation {
    if(mainThruster.isPressed) {
      return firingThrusterAnimation;
    }
    return offThrusterAnimation;
  }

  @override
  void update(double dt) {
    super.update(dt);
    _gravity(dt);
    _engine(dt);
    _rotate(dt);
    _velocity(dt);
    _resetTrigger();
    _colliding(dt);

  }
  void _gravity(double dt) {
    yVel += GRAVITY*dt;
  }
  void _velocity(double dt) {
    x += xVel * dt;
    y += yVel * dt;
  }

  void _colliding(double dt) {
    if(collisionDetector.isColliding(Offset(x, y))){
      print('kek');
      xVel = -xVel * 0.2;
      yVel = -yVel * 0.5;
      x += xVel * dt;
      y += yVel * dt;
    }//

  }

  void _resetTrigger() {
    if  (resetButton.isPressed) _reset();

    if (size != null) {
      if (size != null && this.size.width < x ||
          this.size.height < y || y < 0 || x < 0) _reset();
    }
  }
  void _reset(){
    x = 10;
    y = 10;
    print(xVel);
    print(yVel);
    print(angle);
    xVel = 70;
    yVel = 0;
  }

  void _engine(double dt) {
    if(mainThruster.isPressed){
      yVel += sin(angle - pi/ 2) * ENGINEPOWER * dt;
      xVel += cos(angle - pi / 2) * ENGINEPOWER * dt;
    }
  }
  void _rotate(double dt) {
    if(leftThruster.isPressed) _rotateLeft(dt);
    if(rightThruster.isPressed) _rotateRight(dt);
  }
  void _rotateRight(double dt){
    this.angle += TURNTHRUSTERPOWER * dt;
  }

  void _rotateLeft(double dt){
    this.angle -= TURNTHRUSTERPOWER * dt;
  }
}
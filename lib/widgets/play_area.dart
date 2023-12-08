import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter_flame/screens/space_ship.dart';

class PlayArea extends RectangleComponent with HasGameReference<SpaceShip> {
  PlayArea()
      : super(
          paint: Paint()..color = const Color(0xfff2e8cf),
        );

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    size = Vector2(200, 200);
  }
}

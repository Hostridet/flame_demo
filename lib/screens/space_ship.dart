import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter_flame/widgets/play_area.dart';

class SpaceShip extends FlameGame {
  /// ширина окна
  final double width;

  /// высота окна
  final double height;

  SpaceShip({required this.width, required this.height})
      : super(
          camera: CameraComponent.withFixedResolution(
            width: width,
            height: height,
          ),
        );

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    world.add(PlayArea());
  }
}

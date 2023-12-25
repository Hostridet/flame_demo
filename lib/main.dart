import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame/components/cosmic_game.dart';
import 'widgets/navigation_keys.dart';

void main() {
  final game = CosmicGame();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            GameWidget(
              game: game,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: NavigationKeys(
                onDirectionChanged: game.onArrowKeyChanged,
                onFireTap: game.onFireTap,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

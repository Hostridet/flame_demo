import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame/components/cosmic_game.dart';
import 'package:flutter_flame/utils/play_state.dart';
import 'widgets/navigation_keys.dart';

void main() {
  final game = CosmicGame();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              GameWidget(
                game: game,
                overlayBuilderMap: {
                  PlayState.welcome.name: (context, games) => const Center(
                        child: Text(
                          'TAP TO PLAY',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      ),
                  PlayState.end.name: (context, games) => Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'GAME OVER',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                              ),
                            ),
                            Text(
                              'SCORE: ${game.score.value}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                },
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
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/game_controller.dart';

class OfficerCard extends StatelessWidget {
  final GameController game;

  const OfficerCard({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.cyanAccent.withValues(alpha: 0.6)),
          boxShadow: [
            BoxShadow(
              color: Colors.cyanAccent.withValues(alpha: 0.12),
              blurRadius: 22,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'WELCOME OFFICER',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 13,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              game.rank.value,
              style: const TextStyle(
                color: Colors.cyanAccent,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                const Icon(Icons.military_tech, color: Colors.amberAccent),
                const SizedBox(width: 10),
                Text('Rank: ${game.rank.value}'),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.bolt, color: Colors.cyanAccent),
                const SizedBox(width: 10),
                Text('XP: ${game.xp.value}'),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.shield, color: Colors.greenAccent),
                const SizedBox(width: 10),
                Text('Security Shield: ${game.securityShield.value}%'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/game_controller.dart';
import '../screens/mission_briefing_screen.dart';
import 'mission_card.dart';

class MissionList extends StatelessWidget {
  final GameController game;

  const MissionList({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "TODAY'S MISSIONS",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),

          const SizedBox(height: 16),

          /// ============================
          /// OPERATION LOCKDOWN
          /// ============================
          MissionCard(
            title: 'Operation Lockdown',
            subtitle: 'Cyber Defence Terminal secured',
            icon: Icons.lock,
            status: game.isMissionCompleted(1) ? 'COMPLETED' : 'READY',
            color: Colors.greenAccent,
            onTap: () {},
          ),

          const SizedBox(height: 14),

          /// ============================
          /// OPERATION HOOK
          /// ============================
          MissionCard(
            title: 'Operation Hook',
            subtitle: 'Identify phishing emails before staff click them',
            icon: Icons.phishing,
            status: game.isMissionCompleted(2) ? 'COMPLETED' : 'READY',
            color: Colors.cyanAccent,
            onTap: () {
              Get.to(() => const MissionBriefingScreen());
            },
          ),

          const SizedBox(height: 14),

          /// ============================
          /// OPERATION TROJAN DRIVE
          /// ============================
          MissionCard(
            title: 'Operation Trojan Drive',
            subtitle: 'USB Device Safety',
            icon: Icons.usb,
            status: game.isMissionUnlocked(3) ? 'READY' : 'LOCKED',
            color: Colors.orangeAccent,
            locked: !game.isMissionUnlocked(3),
            onTap: () {
              // Mission 3 will go here later.
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/game_controller.dart';
import 'commander_debrief_screen.dart';

class MissionCompleteScreen extends StatefulWidget {
  const MissionCompleteScreen({super.key});

  @override
  State<MissionCompleteScreen> createState() => _MissionCompleteScreenState();
}

class _MissionCompleteScreenState extends State<MissionCompleteScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulse;

  final game = Get.find<GameController>();

  int displayedXP = 0;
  int displayedShield = 0;

  @override
  void initState() {
    super.initState();

    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _animateStats();
  }

  Future<void> _animateStats() async {
    for (int i = 0; i <= 150; i += 5) {
      await Future.delayed(const Duration(milliseconds: 18));

      if (!mounted) return;

      setState(() {
        displayedXP = i;
      });
    }

    for (int i = 0; i <= 10; i++) {
      await Future.delayed(const Duration(milliseconds: 45));

      if (!mounted) return;

      setState(() {
        displayedShield = i;
      });
    }
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  Widget rewardCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .05),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: color.withValues(alpha: .55)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 34),

          const SizedBox(width: 18),

          Expanded(child: Text(title, style: const TextStyle(fontSize: 17))),

          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
        ],
      ),
    );
  }

  Widget badgeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 22),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.amber, width: 1.3),
        boxShadow: [
          BoxShadow(color: Colors.amber.withValues(alpha: .18), blurRadius: 18),
        ],
      ),
      child: const Column(
        children: [
          Icon(Icons.workspace_premium, color: Colors.amber, size: 60),

          SizedBox(height: 15),

          Text(
            "BADGE UNLOCKED",
            style: TextStyle(
              color: Colors.white54,
              letterSpacing: 3,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 15),

          Text(
            "PHISHING HUNTER",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.amber,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff05070D),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Column(
            children: [
              const SizedBox(height: 15),

              FadeTransition(
                opacity: _pulse,
                child: const Icon(
                  Icons.gpp_good_rounded,
                  size: 120,
                  color: Colors.greenAccent,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "MISSION COMPLETE",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                "Operation Hook",
                style: TextStyle(
                  color: Colors.cyanAccent,
                  fontSize: 20,
                  letterSpacing: 2,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                "★★★★★",
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 22,
                  letterSpacing: 4,
                ),
              ),

              const SizedBox(height: 35),

              rewardCard(
                icon: Icons.workspace_premium,
                title: "XP Earned",
                value: "+$displayedXP",
                color: Colors.amberAccent,
              ),

              rewardCard(
                icon: Icons.shield,
                title: "Shield Bonus",
                value: "+$displayedShield%",
                color: Colors.greenAccent,
              ),

              rewardCard(
                icon: Icons.verified_user,
                title: "Threat",
                value: "NEUTRALIZED",
                color: Colors.cyanAccent,
              ),

              const SizedBox(height: 10),

              badgeCard(),

              const SizedBox(height: 35),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text(
                    "CONTINUE",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 3,
                    ),
                  ),
                  onPressed: () {
                    Get.off(() => const CommanderDebriefScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyanAccent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}

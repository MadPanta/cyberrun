import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'mission_objectives_screen.dart';

class MissionBriefingScreen extends StatefulWidget {
  const MissionBriefingScreen({super.key});

  @override
  State<MissionBriefingScreen> createState() => _MissionBriefingScreenState();
}

class _MissionBriefingScreenState extends State<MissionBriefingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;

  final String _fullMessage =
      'Officer,\n\n'
      'Our monitoring systems have detected a coordinated phishing campaign targeting RADA employees.\n\n'
      'Several staff members have received suspicious emails pretending to be from the ICT Department.\n\n'
      'Your mission is to identify the malicious email before anyone clicks the link.\n\n'
      'Stay alert. One wrong decision could compromise the RADA network.';

  String _typedMessage = '';
  bool _typingFinished = false;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    )..repeat(reverse: true);

    _typeMessage();
  }

  Future<void> _typeMessage() async {
    for (int i = 0; i < _fullMessage.length; i++) {
      await Future.delayed(const Duration(milliseconds: 22));

      if (!mounted) return;

      setState(() {
        _typedMessage += _fullMessage[i];
      });
    }

    if (!mounted) return;

    setState(() {
      _typingFinished = true;
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Widget _infoTile({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title, style: const TextStyle(color: Colors.white70)),
          ),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF05070D),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeTransition(
                opacity: _pulseController,
                child: const Row(
                  children: [
                    Icon(Icons.sensors, color: Colors.cyanAccent),
                    SizedBox(width: 10),
                    Text(
                      'INCOMING TRANSMISSION',
                      style: TextStyle(
                        color: Colors.cyanAccent,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.cyanAccent.withValues(alpha: 0.7),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.cyanAccent.withValues(alpha: 0.15),
                      blurRadius: 22,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'DIRECTOR AEGIS',
                      style: TextStyle(
                        color: Colors.cyanAccent,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Cyber Defence Command',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 13,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 22),
                    Text(
                      _typedMessage + (_typingFinished ? '' : '|'),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15.5,
                        height: 1.55,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              _infoTile(
                icon: Icons.security,
                title: 'Operation',
                value: 'HOOK',
                color: Colors.cyanAccent,
              ),
              _infoTile(
                icon: Icons.star,
                title: 'Difficulty',
                value: '★★☆☆☆',
                color: Colors.orangeAccent,
              ),
              _infoTile(
                icon: Icons.workspace_premium,
                title: 'Reward',
                value: '+150 XP',
                color: Colors.greenAccent,
              ),
              _infoTile(
                icon: Icons.emoji_events,
                title: 'Badge',
                value: 'Phishing Hunter',
                color: Colors.amberAccent,
              ),

              const SizedBox(height: 28),

              AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: _typingFinished ? 1 : 0.35,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _typingFinished
                        ? () {
                            Get.to(() => const MissionObjectivesScreen());
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyanAccent,
                      foregroundColor: Colors.black,
                      disabledBackgroundColor: Colors.grey.shade800,
                      disabledForegroundColor: Colors.white38,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                    ),
                    child: const Text(
                      'DEPLOY',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

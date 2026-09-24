import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'operations_centre_screen.dart';

class CommanderDebriefScreen extends StatefulWidget {
  const CommanderDebriefScreen({super.key});

  @override
  State<CommanderDebriefScreen> createState() => _CommanderDebriefScreenState();
}

class _CommanderDebriefScreenState extends State<CommanderDebriefScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  String displayedText = "";

  bool finished = false;

  final String briefing = '''

Excellent work, Officer.

Your quick actions successfully contained the phishing attack before staff credentials could be compromised.

The Cyber Defence Command has awarded you the Phishing Hunter Badge and 150 XP.

Unfortunately, our monitoring systems have already detected another security incident.

A suspicious USB storage device has been connected to a workstation at one of our regional offices.

Initial scans indicate that the device may contain malicious software capable of spreading across the RADA network.

Your next assignment has been authorised.

Operation Trojan Drive has been unlocked.

Prepare for deployment.

''';

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _typeText();
  }

  Future<void> _typeText() async {
    for (int i = 0; i < briefing.length; i++) {
      await Future.delayed(const Duration(milliseconds: 18));

      if (!mounted) return;

      setState(() {
        displayedText += briefing[i];
      });
    }

    setState(() {
      finished = true;
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Widget infoTile(IconData icon, String title, String value, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .05),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withValues(alpha: .45)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),

          const SizedBox(width: 15),

          Expanded(child: Text(title)),

          Text(
            value,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
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
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              FadeTransition(
                opacity: _pulseController,
                child: const Row(
                  children: [
                    Icon(Icons.sensors, color: Colors.cyanAccent),

                    SizedBox(width: 10),

                    Text(
                      "SECURE TRANSMISSION",
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

              const SizedBox(height: 30),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .05),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.cyanAccent),
                ),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.cyanAccent,
                      child: Icon(Icons.shield, color: Colors.black, size: 45),
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      "DIRECTOR AEGIS",
                      style: TextStyle(
                        color: Colors.cyanAccent,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),

                    const SizedBox(height: 4),

                    const Text(
                      "Cyber Defence Commander",
                      style: TextStyle(color: Colors.white54),
                    ),

                    const SizedBox(height: 25),

                    Text(
                      displayedText,
                      style: const TextStyle(height: 1.6, fontSize: 15.5),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              infoTile(
                Icons.lock_open,
                "Mission Unlocked",
                "Operation Trojan Drive",
                Colors.orangeAccent,
              ),

              infoTile(
                Icons.usb,
                "Threat",
                "Suspicious USB Device",
                Colors.redAccent,
              ),

              infoTile(
                Icons.location_on,
                "Location",
                "Regional Office",
                Colors.greenAccent,
              ),

              const SizedBox(height: 30),

              AnimatedOpacity(
                opacity: finished ? 1 : 0,
                duration: const Duration(milliseconds: 700),

                child: SizedBox(
                  width: double.infinity,

                  child: ElevatedButton(
                    onPressed: finished
                        ? () {
                            Get.offAll(() => const OperationsCentreScreen());
                          }
                        : null,

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyanAccent,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                    ),

                    child: const Text(
                      "RETURN TO OPERATIONS CENTRE",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
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

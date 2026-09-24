import 'package:flutter/material.dart';

class ThreatPanel extends StatelessWidget {
  const ThreatPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.greenAccent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.greenAccent.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'THREAT LEVEL',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 13,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'LOW',
            style: TextStyle(
              color: Colors.greenAccent,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
            ),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const LinearProgressIndicator(
              value: 0.25,
              minHeight: 14,
              backgroundColor: Colors.white12,
              color: Colors.greenAccent,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Terminal secured. New threat detected: phishing emails targeting RADA staff.',
            style: TextStyle(color: Colors.white70, height: 1.5),
          ),
        ],
      ),
    );
  }
}

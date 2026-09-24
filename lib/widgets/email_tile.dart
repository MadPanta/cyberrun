import 'package:flutter/material.dart';

import '../models/email_message.dart';

class EmailTile extends StatelessWidget {
  final EmailMessage email;
  final bool handled;
  final VoidCallback onTap;

  const EmailTile({
    super.key,
    required this.email,
    required this.handled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = handled ? Colors.greenAccent : Colors.cyanAccent;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: handled ? 0.035 : 0.07),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: statusColor.withValues(alpha: handled ? 0.35 : 0.65),
          ),
        ),
        child: Row(
          children: [
            Icon(
              handled ? Icons.mark_email_read : Icons.mark_email_unread,
              color: statusColor,
              size: 32,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    email.sender,
                    style: TextStyle(
                      color: handled ? Colors.white54 : Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    email.subject,
                    style: TextStyle(
                      color: handled ? Colors.white38 : Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    email.preview,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white38, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Icon(
              Icons.chevron_right,
              color: handled ? Colors.white24 : Colors.white54,
            ),
          ],
        ),
      ),
    );
  }
}

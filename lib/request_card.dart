import 'package:flutter/material.dart';
import 'app_image.dart';

class RequestCard extends StatelessWidget {
  final IconData icon;
  final String date;
  final String leftLabel;
  final String leftValue;
  final String rightLabel;
  final String rightValue;
  final String? statusText;
  final bool approved;

  const RequestCard({
    super.key,
    required this.icon,
    required this.date,
    required this.leftLabel,
    required this.leftValue,
    required this.rightLabel,
    required this.rightValue,
    this.statusText,
    this.approved = true,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor = approved ? Colors.green : Colors.red;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: const Color(0xFF7A5AF8)),
              const SizedBox(width: 6),
              Text(date, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F7FB),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(leftLabel,
                        style: const TextStyle(fontSize: 9, color: Colors.grey)),
                    const SizedBox(height: 2),
                    Text(leftValue, style: const TextStyle(fontSize: 12)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(rightLabel,
                        style: const TextStyle(fontSize: 9, color: Colors.grey)),
                    const SizedBox(height: 2),
                    Text(rightValue, style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          if (statusText != null) ...[
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(approved ? Icons.check_circle : Icons.cancel,
                        size: 12, color: statusColor),
                    const SizedBox(width: 4),
                    Text(statusText!,
                        style: TextStyle(fontSize: 10, color: statusColor)),
                  ],
                ),
                Row(
                  children: [
                    const Text('By ', style: TextStyle(fontSize: 10)),
                    ClipOval(
                      child: AppImage('assets/images/avatar_elaine.png',
                          width: 16, height: 16),
                    ),
                    const SizedBox(width: 4),
                    const Text('Elaine', style: TextStyle(fontSize: 10)),
                  ],
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
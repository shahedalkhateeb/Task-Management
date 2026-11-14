import 'package:flutter/material.dart';
import 'app_image.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String status;
  final double progress;
  final Color background;
  final String date;
  final String avatarPath;
  final double avatarWidth;
  final String priority;

  const TaskCard({
    super.key,
    required this.title,
    this.status = 'In Progress',
    this.progress = 0.85,
    this.background = const Color(0xFFF7F7FB),
    this.date = '27 April',
    this.avatarPath = 'assets/images/avatars.png',
    this.avatarWidth = 50,
    this.priority = 'High',
  });

  Widget chip(Widget content, Color bg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
      child: content,
    );
  }

  Widget smallBox(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 10, color: Colors.grey),
          const SizedBox(width: 4),
          Text(text, style: const TextStyle(fontSize: 9)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool done = status == 'Done';

    Color priorityColor = priority == 'High'
        ? Colors.red
        : priority == 'Medium'
        ? Colors.orange
        : Colors.green;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 9,
                backgroundColor: Color(0xFF7A5AF8),
                child: Icon(Icons.bolt, size: 11, color: Colors.white),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(title,
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              done
                  ? chip(
                const Row(
                  children: [
                    Icon(Icons.check_circle, size: 10, color: Colors.green),
                    SizedBox(width: 4),
                    Text('Done', style: TextStyle(fontSize: 9, color: Colors.green)),
                  ],
                ),
                const Color(0xFFDCFCE7),
              )
                  : chip(
                const Row(
                  children: [
                    CircleAvatar(radius: 3, backgroundColor: Colors.grey),
                    SizedBox(width: 4),
                    Text('In Progress', style: TextStyle(fontSize: 9)),
                  ],
                ),
                const Color(0xFFE5E7EB),
              ),
              const SizedBox(width: 6),
              chip(
                Row(
                  children: [
                    const Icon(Icons.flag, size: 10, color: Colors.white),
                    const SizedBox(width: 3),
                    Text(priority,
                        style: const TextStyle(fontSize: 9, color: Colors.white)),
                  ],
                ),
                priorityColor,
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 4,
              color: const Color(0xFF7A5AF8),
              backgroundColor: const Color(0xFFE5E7EB),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppImage(avatarPath, width: avatarWidth, height: 20),
              Row(
                children: [
                  smallBox(Icons.calendar_today, date),
                  const SizedBox(width: 6),
                  smallBox(Icons.chat_bubble_outline, '2'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
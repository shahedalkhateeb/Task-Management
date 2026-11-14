import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget> boxes;
  final Widget? bottom;

  const SummaryCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.boxes,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
    for (int i = 0; i < boxes.length; i++) {
      if (i > 0) items.add(const SizedBox(width: 8));
      items.add(Expanded(child: boxes[i]));
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(subtitle, style: const TextStyle(fontSize: 9, color: Colors.grey)),
          const SizedBox(height: 10),
          Row(children: items),
          if (bottom != null) ...[
            const SizedBox(height: 12),
            bottom!,
          ],
        ],
      ),
    );
  }
}
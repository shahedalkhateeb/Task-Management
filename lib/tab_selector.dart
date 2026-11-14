import 'package:flutter/material.dart';

class TabSelector extends StatelessWidget {
  final List<String> labels;
  final List<int> counts;
  final int selected;
  final ValueChanged<int> onChanged;

  const TabSelector({
    super.key,
    required this.labels,
    required this.counts,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: List.generate(labels.length, (i) {
          bool isSelected = i == selected;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(i),
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF7A5AF8) : Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      labels[i],
                      style: TextStyle(
                        fontSize: 11,
                        color: isSelected ? Colors.white : const Color(0xFF4B5563),
                      ),
                    ),
                    if (counts[i] > 0) ...[
                      const SizedBox(width: 4),
                      Container(
                        width: 14,
                        height: 14,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFFF5A3C)
                              : const Color(0xFFD1D5DB),
                          shape: BoxShape.circle,
                        ),
                        child: Text('${counts[i]}',
                            style: const TextStyle(fontSize: 8, color: Colors.white)),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
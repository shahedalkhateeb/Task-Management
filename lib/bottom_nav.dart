import 'package:flutter/material.dart';

class MyBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const MyBottomNav({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    List<IconData> icons = [
      Icons.home,
      Icons.calendar_month,
      Icons.event_available,
      Icons.assignment,
      Icons.layers,
    ];

    return Container(
      color: const Color(0xFF18181B),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 58,
          child: Row(
            children: List.generate(5, (i) {
              bool selected = i == currentIndex;
              return Expanded(
                child: InkWell(
                  onTap: () => onTap(i),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icons[i],
                          size: 22,
                          color: selected ? Colors.white : Colors.white54),
                      const SizedBox(height: 4),
                      Container(
                        width: 18,
                        height: 2,
                        color: selected ? Colors.white : Colors.transparent,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
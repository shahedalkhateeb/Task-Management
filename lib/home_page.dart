import 'package:flutter/material.dart';
import 'bottom_nav.dart';
import 'home_tab.dart';
import 'clock_in_tab.dart';
import 'task_tab.dart';
import 'expense_tab.dart';
import 'leave_tab.dart';

final ValueNotifier<int> homeTabNotifier = ValueNotifier<int>(0);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedTab = 0;

  void onTabChanged() {
    setState(() {
      selectedTab = homeTabNotifier.value;
    });
  }

  @override
  void initState() {
    super.initState();
    homeTabNotifier.value = 0;
    homeTabNotifier.addListener(onTabChanged);
  }

  @override
  void dispose() {
    homeTabNotifier.removeListener(onTabChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedTab,
        children: const [
          HomeTab(),
          ClockInTab(),
          TaskTab(),
          ExpenseTab(),
          LeaveTab(),
        ],
      ),
      bottomNavigationBar: MyBottomNav(
        currentIndex: selectedTab,
        onTap: (index) {
          homeTabNotifier.value = index;
        },
      ),
    );
  }
}
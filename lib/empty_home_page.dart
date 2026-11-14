import 'package:flutter/material.dart';
import 'welcome_sheet.dart';

class EmptyHomePage extends StatefulWidget {
  final bool showWelcome;

  const EmptyHomePage({super.key, this.showWelcome = false});

  @override
  State<EmptyHomePage> createState() => _EmptyHomePageState();
}

class _EmptyHomePageState extends State<EmptyHomePage> {
  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
    if (widget.showWelcome) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showWelcomeSheet(context);
      });
    }
  }

  Widget emptyCard(String title, String subtitle, IconData icon, String emptyTitle, String emptyText) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style:  TextStyle(fontWeight: FontWeight.bold)),
          Text(subtitle, style:  TextStyle(color: Colors.grey, fontSize: 12)),
           SizedBox(height: 20),
          Center(child: Icon(icon, size: 60, color: const Color(0xFFD9D3F5))),
           SizedBox(height: 8),
          Center(
            child: Text(emptyTitle,
                style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          ),
           SizedBox(height: 4),
          Center(
            child: Text(
              emptyText,
              textAlign: TextAlign.center,
              style:  TextStyle(fontSize: 9, color: Colors.grey),
            ),
          ),
           SizedBox(height: 10),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedTab,
        onTap: (index) {
          setState(() {
            selectedTab = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: const Color(0xFF7A5AF8),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.how_to_reg), label: 'Attendance'),
          BottomNavigationBarItem(icon: Icon(Icons.layers), label: 'More'),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              children: [
                 CircleAvatar(child: Icon(Icons.person)),
                 SizedBox(width: 10),
                 Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tonald Drump', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Tonald@work.com',
                          style: TextStyle(color: Color(0xFF7A5AF8), fontSize: 12)),
                    ],
                  ),
                ),
                IconButton(onPressed: () {}, icon:
                Icon(Icons.chat_bubble_outline)),
                IconButton(onPressed: () {}, icon:
                Icon(Icons.notifications_none)),
              ],
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF7A5AF8),
                borderRadius: BorderRadius.circular(15),
              ),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('My Work Summary',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  Text('Today task & presence activity',
                      style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
             SizedBox(height: 15),
            emptyCard(
              'Today Meeting',
              'Your schedule for the day',
              Icons.event_busy,
              'No Meeting Available',
              "It looks like you don't have any meetings scheduled at the moment. This space will be updated as new meetings are added.",
            ),
             SizedBox(height: 15),
            emptyCard(
              'Today Task',
              'The tasks assigned to you for today',
              Icons.assignment_outlined,
              'No Tasks Assigned',
              "It looks like you don't have any tasks assigned to you right now. This space will be updated as new tasks become available.",
            ),
          ],
        ),
      ),
    );
  }
}
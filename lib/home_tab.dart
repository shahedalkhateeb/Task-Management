import 'package:flutter/material.dart';
import 'app_image.dart';
import 'task_card.dart';
import 'messages_pages.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  Widget numberBadge(String number) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFEDE9FE),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(number,
          style:  TextStyle(fontSize: 9, color: Color(0xFF7A5AF8))),
    );
  }

  Widget sectionCard(String title, String badge, String subtitle, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(title, style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
               SizedBox(width: 6),
              numberBadge(badge),
            ],
          ),
           SizedBox(height: 2),
          Text(subtitle, style:  TextStyle(fontSize: 9, color: Colors.grey)),
           SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }

  Widget meetingTile(String name, bool showPlus) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7FB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        children: [
          Row(
            children: [
               CircleAvatar(
                radius: 10,
                backgroundColor: Color(0xFF7A5AF8),
                child: Icon(Icons.videocam, size: 12, color: Colors.white),
              ),
               SizedBox(width: 8),
              Expanded(
                child: Text(name,
                    style:  TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
              ),
               Icon(Icons.access_time, size: 11, color: Colors.grey),
               SizedBox(width: 4),
               Text('01:30 AM - 02:00 AM',
                  style: TextStyle(fontSize: 9, color: Colors.grey)),
            ],
          ),
           SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                   AppImage('assets/images/avatars.png', width: 50, height: 20),
                  if (showPlus)
                     Text(' +3', style: TextStyle(fontSize: 10)),
                ],
              ),
              Container(
                padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color:  Color(0xFF7A5AF8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child:  Text('Join Meet',
                    style: TextStyle(fontSize: 9, color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget roundIcon(BuildContext context, IconData icon, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Container(
        width: 32,
        height: 32,
        margin:  EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
          color:  Color(0xFFEDE9FE),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(icon, size: 16, color:  Color(0xFF7A5AF8)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF4F3FA),
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: Row(
                  children: [
                    ClipOval(
                      child: AppImage('assets/images/profile.png',
                          width: 40, height: 40, fit: BoxFit.cover),
                    ),
                     SizedBox(width: 10),
                     Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('Tonald Drump',
                                  style: TextStyle(
                                      fontSize: 13, fontWeight: FontWeight.bold)),
                              SizedBox(width: 4),
                              Icon(Icons.verified, size: 14, color: Color(0xFF7A5AF8)),
                            ],
                          ),
                          Text('Junior Full Stack Developer',
                              style: TextStyle(fontSize: 10, color: Color(0xFF7A5AF8))),
                        ],
                      ),
                    ),
                    roundIcon(context, Icons.chat_bubble_outline,
                        MessagesPage()),
                    roundIcon(context, Icons.notifications_none,
                        NotificationsPage()),
                  ],
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7A5AF8),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                       Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('My Work Summary',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 2),
                            Text('Today task & presence activity',
                                style: TextStyle(color: Colors.white70, fontSize: 10)),
                          ],
                        ),
                      ),
                       AppImage('assets/images/work_summary.png',
                          width: 80, height: 56),
                    ],
                  ),
                ),
                 SizedBox(height: 12),

                sectionCard('Today Meeting', '2', 'Your schedule for the day', [
                  meetingTile('Townhall Meeting', true),
                  meetingTile('Dashboard Report', false),
                ]),
                 SizedBox(height: 12),

                sectionCard('Today Task', '1', 'The tasks assigned to you for today', [
                   TaskCard(title: 'Wiring Dashboard Analytics'),
                ]),
                 SizedBox(height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
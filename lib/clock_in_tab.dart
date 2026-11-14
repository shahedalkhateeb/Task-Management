import 'package:flutter/material.dart';
import 'my_button.dart';
import 'purple_header.dart';
import 'summary_card.dart';
import 'stat_box.dart';
import 'attendance_pages.dart';

class ClockInTab extends StatefulWidget {
  const ClockInTab({super.key});

  @override
  State<ClockInTab> createState() => _ClockInTabState();
}

class _ClockInTabState extends State<ClockInTab> {


  int status = 0;

  List<Map<String, String>> records = [
    {'date': '27 September 2024', 'hours': '08:00:00 hrs', 'time': '09:00 AM  —  05:00 PM'},
    {'date': '26 September 2024', 'hours': '08:00:00 hrs', 'time': '09:00 AM  —  05:00 PM'},
    {'date': '25 September 2024', 'hours': '08:10:00 hrs', 'time': '09:00 AM  —  05:10 PM'},
  ];

  String get todayText {
    if (status == 0) return '00:00 Hrs';
    if (status == 3) return '08:00 Hrs';
    return '04:10 Hrs';
  }

  void startClockIn() async {
    bool? done = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => const ClockInAreaPage()),
    );
    if (done == true && mounted) {
      setState(() {
        status = 1;
      });
    }
  }

  void clockOut() async {
    int? answer = await showIconPopup(
      context,
      icon: Icons.access_time_filled,
      title: 'Confirm Clockout',
      text:
      "Once you clock out, you won't be able to edit this time. Please double-check your hours before proceeding.",
      buttons: ['Yes, Clock Out', 'No, Let me check'],
      extra:  Row(
        children: [
          Expanded(child: StatBox(label: 'Today', value: '08:00:00 Hrs', dotColor: Colors.grey)),
          SizedBox(width: 8),
          Expanded(child: StatBox(label: 'Overtime', value: '00:00:00 Hrs', dotColor: Colors.grey)),
        ],
      ),
    );
    if (answer != 0 || !mounted) return;

    await showIconPopup(
      context,
      icon: Icons.access_time_filled,
      title: 'Clockout Successful!',
      text:
      "You've officially clocked out for the day. Thank you for your hard work! Time to relax and enjoy your break.",
      buttons: ['Close Message'],
    );
    if (!mounted) return;

    setState(() {
      status = 3;
      records.insert(0, {
        'date': '28 September 2024',
        'hours': '08:00:00 hrs',
        'time': '09:00 AM  —  05:00 PM',
      });
    });
  }

  Widget actionButtons() {
    if (status == 0) {
      return MyButton(text: 'Clock In Now', onPressed: startClockIn);
    }

    if (status == 3) {
      return MyButton(text: 'Clocked Out', enabled: false, onPressed: () {});
    }

    return Row(
      children: [
        Expanded(
          child: status == 1
              ? MyButton(
            text: 'Take A Break',
            filled: false,
            onPressed: () {
              setState(() {
                status = 2;
              });
            },
          )
              : MyButton(
            text: 'Back To Work',
            onPressed: () {
              setState(() {
                status = 1;
              });
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: MyButton(text: 'Clock Out', dark: true, onPressed: clockOut),
        ),
      ],
    );
  }

  Widget recordCard(Map<String, String> record) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AttendanceDetailsPage(record: record)),
        );
      },
      child: Container(
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
                const Icon(Icons.calendar_today, size: 12, color: Color(0xFF7A5AF8)),
                const SizedBox(width: 6),
                Text(record['date']!,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
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
                       Text('Total Hours',
                          style: TextStyle(fontSize: 9, color: Colors.grey)),
                       SizedBox(height: 2),
                      Text(record['hours']!, style:  TextStyle(fontSize: 11)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text('Clock in & Out',
                          style: TextStyle(fontSize: 9, color: Colors.grey)),
                       SizedBox(height: 2),
                      Text(record['time']!, style:  TextStyle(fontSize: 11)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF4F3FA),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          PurpleHeader(
            title: "Let's Clock-In!",
            subtitle: "Don't miss your clock in schedule",
            imagePath: 'assets/images/clockin_header.png',
            card: SummaryCard(
              title: 'Total Working Hour',
              subtitle: 'Paid Period 1 Sept 2024 - 30 Sept 2024',
              boxes: [
                StatBox(label: 'Today', value: todayText, dotColor: Colors.grey),
                 StatBox(label: 'This Pay Period', value: '32:00 Hrs', dotColor: Colors.grey),
              ],
              bottom: actionButtons(),
            ),
          ),
           SizedBox(height: 12),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: records.map((record) => recordCard(record)).toList(),
            ),
          ),
           SizedBox(height: 10),
        ],
      ),
    );
  }
}
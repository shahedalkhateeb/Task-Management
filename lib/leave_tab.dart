import 'package:flutter/material.dart';
import 'app_image.dart';
import 'purple_header.dart';
import 'summary_card.dart';
import 'stat_box.dart';
import 'tab_selector.dart';
import 'request_card.dart';
import 'bottom_button_bar.dart';
import 'submit_leave_page.dart';

class LeaveTab extends StatefulWidget {
  const LeaveTab({super.key});

  @override
  State<LeaveTab> createState() => _LeaveTabState();
}

class _LeaveTabState extends State<LeaveTab> {
  int tabIndex = 0;

  List<List<Map<String, String>>> data = [
    [],
    // Approved
    [
      {'date': '18 September 2024', 'leaveDate': '20 Sept - 22 Sept', 'days': '2 Days', 'status': 'Approved at 19 Sept 2024'},
    ],
    // Rejected
    [
      {'date': '21 September 2024', 'leaveDate': '10 Nov - 17 Nov', 'days': '7 Days', 'status': 'Rejected at 22 Sept 2024'},
    ],
  ];

  void submitLeave() async {
    Map<String, String>? result = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(builder: (context) => const SubmitLeavePage()),
    );

    if (result != null && mounted) {
      setState(() {
        data[0].insert(0, {
          'date': result['date']!,
          'leaveDate': result['leaveDate']!,
          'days': result['days']!,
          'status': '',
        });
        tabIndex = 0;
      });
    }
  }

  Widget emptyCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Leave Submitted',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          Text('Leave information', style: TextStyle(fontSize: 9, color: Colors.grey)),
          SizedBox(height: 24),
          Center(child: AppImage('assets/images/leave_empty.png', width: 70, height: 80)),
          SizedBox(height: 8),
          Center(
            child: Text('No Leave Submitted!',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 4),
          Center(
            child: Text(
              'Ready to catch some fresh air? Click "Submit Leave" and take that well-deserved break!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 8, color: Colors.grey),
            ),
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> items = data[tabIndex];

    return Container(
      color: const Color(0xFFF4F3FA),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const PurpleHeader(
                  title: 'Leave Summary',
                  subtitle: 'Submit Leave',
                  imagePath: 'assets/images/leave_header.png',
                  card: SummaryCard(
                    title: 'Total Leave',
                    subtitle: 'Period 1 Jan 2024 - 30 Dec 2024',
                    boxes: [
                      StatBox(label: 'Available', value: '20', dotColor: Colors.green),
                      StatBox(label: 'Leave Used', value: '2', dotColor: Color(0xFF7A5AF8)),
                    ],
                  ),
                ),
                 SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      TabSelector(
                        labels: const ['Review', 'Approved', 'Rejected'],
                        counts: [data[0].length, 0, 0],
                        selected: tabIndex,
                        onChanged: (index) {
                          setState(() {
                            tabIndex = index;
                          });
                        },
                      ),
                       SizedBox(height: 12),

                      if (items.isEmpty) emptyCard(),

                      ...items.map((item) {
                        String status = item['status']!;
                        return RequestCard(
                          icon: Icons.event_note,
                          date: item['date']!,
                          leftLabel: 'Leave Date',
                          leftValue: item['leaveDate']!,
                          rightLabel: 'Total Leave',
                          rightValue: item['days']!,
                          statusText: status.isEmpty ? null : status,
                          approved: tabIndex == 1,
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
          BottomButtonBar(text: 'Submit Leave', onPressed: submitLeave),
        ],
      ),
    );
  }
}
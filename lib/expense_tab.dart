import 'package:flutter/material.dart';
import 'purple_header.dart';
import 'summary_card.dart';
import 'stat_box.dart';
import 'tab_selector.dart';
import 'request_card.dart';
import 'bottom_button_bar.dart';
import 'submit_expense_page.dart';

class ExpenseTab extends StatefulWidget {
  const ExpenseTab({super.key});

  @override
  State<ExpenseTab> createState() => _ExpenseTabState();
}

class _ExpenseTabState extends State<ExpenseTab> {
  int tabIndex = 0;

  List<List<Map<String, String>>> data = [
    // Review
    [
      {'date': '27 September 2024', 'type': 'E-Learning', 'amount': '\$55', 'status': ''},
      {'date': '24 September 2024', 'type': 'E-Learning', 'amount': '\$55', 'status': ''},
      {'date': '21 September 2024', 'type': 'E-Learning', 'amount': '\$55', 'status': ''},
    ],
    // Approved
    [
      {'date': '18 September 2024', 'type': 'E-Learning', 'amount': '\$55', 'status': 'Approved at 19 Sept 2024'},
      {'date': '14 September 2024', 'type': 'E-Learning', 'amount': '\$55', 'status': 'Approved at 19 Sept 2024'},
    ],
    // Rejected
    [
      {'date': '27 September 2024', 'type': 'Business Trip', 'amount': '\$100', 'status': 'Rejected at 28 Sept 2024'},
      {'date': '24 September 2024', 'type': 'Business Trip', 'amount': '\$100', 'status': 'Rejected at 28 Sept 2024'},
    ],
  ];

  void submitExpense() async {
    Map<String, String>? result = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(builder: (context) => const SubmitExpensePage()),
    );

    if (result != null && mounted) {
      setState(() {
        data[0].insert(0, {
          'date': result['date']!,
          'type': result['type']!,
          'amount': result['amount']!,
          'status': '',
        });
        tabIndex = 0;
      });
    }
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
                 PurpleHeader(
                  title: 'Expense Summary',
                  subtitle: 'Claim your expenses here.',
                  imagePath: 'assets/images/expense_header.png',
                  card: SummaryCard(
                    title: 'Total Expense',
                    subtitle: 'Period 1 Jan 2024 - 30 Dec 2024',
                    boxes: [
                      StatBox(label: 'Total', value: '\$1010', dotColor: Color(0xFF7A5AF8)),
                      StatBox(label: 'Review', value: '\$455', dotColor: Colors.orange),
                      StatBox(label: 'Approved', value: '\$555', dotColor: Colors.green),
                    ],
                  ),
                ),
                 SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      TabSelector(
                        labels:  ['Review', 'Approved', 'Rejected'],
                        counts: [data[0].length, data[1].length, data[2].length],
                        selected: tabIndex,
                        onChanged: (index) {
                          setState(() {
                            tabIndex = index;
                          });
                        },
                      ),
                       SizedBox(height: 12),
                      ...items.map((item) {
                        String status = item['status']!;
                        return RequestCard(
                          icon: Icons.receipt_long,
                          date: item['date']!,
                          leftLabel: 'Type',
                          leftValue: item['type']!,
                          rightLabel: 'Total Expense',
                          rightValue: item['amount']!,
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
          BottomButtonBar(text: 'Submit Expense', onPressed: submitExpense),
        ],
      ),
    );
  }
}
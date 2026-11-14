import 'package:flutter/material.dart';
import 'app_image.dart';
import 'my_text_field.dart';
import 'summary_card.dart';
import 'stat_box.dart';
import 'bottom_button_bar.dart';
import 'attendance_pages.dart';

const _purple = Color(0xFF7A5AF8);

AppBar _appBar(BuildContext context, String title) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    automaticallyImplyLeading: false,
    leading: Padding(
      padding: const EdgeInsets.all(12),
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child:  CircleAvatar(
          radius: 14,
          backgroundColor: Color(0xFFEDE9FE),
          child: Icon(Icons.arrow_back_ios_new, size: 12, color: _purple),
        ),
      ),
    ),
    title: Text(title, style:  TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
  );
}

class OfficeAssetsPage extends StatelessWidget {
  const OfficeAssetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F3FA),
      appBar: _appBar(context, 'Office Assets'),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text('Assets Information',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                 Text('Your office assets information',
                    style: TextStyle(fontSize: 9, color: Colors.grey)),
                 SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: AppImage('assets/images/asset_laptop.png',
                      width: double.infinity, height: 190, fit: BoxFit.cover),
                ),
                 SizedBox(height: 14),

                 MySelectField(
                  label: 'Assets Name',
                  icon: Icons.terminal,
                  value: 'Laptop Macbook Air M1 2020',
                  showArrow: false,
                ),
                 MySelectField(
                  label: 'Brand',
                  icon: Icons.business,
                  value: 'Apple',
                  showArrow: false,
                ),
                      MySelectField(
                  label: 'Warranty Status',
                  icon: Icons.shield_outlined,
                  value: 'Off',
                  showArrow: false,
                ),
                 MySelectField(
                  label: 'Buying Date',
                  icon: Icons.sell_outlined,
                  value: '12 September 2020',
                  showArrow: false,
                ),
                 MySelectField(
                  label: 'Received On',
                  icon: Icons.calendar_month,
                  value: '14 September 2020',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PayrollPage extends StatelessWidget {
  const PayrollPage({super.key});

  final List<Map<String, String>> months = const [
    {'month': 'September 2024', 'period': '1 Sept 2024 - 30 Sept 2024', 'paid': '30 Sept 2024'},
    {'month': 'August 2024', 'period': '1 Aug 2024 - 31 Aug 2024', 'paid': '30 Aug 2024'},
    {'month': 'July 2024', 'period': '1 Jul 2024 - 31 Jul 2024', 'paid': '30 Jul 2024'},
    {'month': 'June 2024', 'period': '1 Jun 2024 - 30 Jun 2024', 'paid': '30 Jun 2024'},
    {'month': 'May 2024', 'period': '1 May 2024 - 31 May 2024', 'paid': '30 May 2024'},
    {'month': 'April 2024', 'period': '1 Apr 2024 - 30 Apr 2024', 'paid': '30 Apr 2024'},
  ];

  Widget column(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 8, color: Colors.grey)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontSize: 11)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F3FA),
      appBar: _appBar(context, 'Payroll and Tax'),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: months.map((item) {
          return GestureDetector(
            onTap: () async {
              bool? saved = await Navigator.push<bool>(
                context,
                MaterialPageRoute(
                    builder: (context) => PayrollDetailsPage(month: item)),
              );
              if (saved == true && context.mounted) Navigator.pop(context);
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
                  Text(item['month']!,
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
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
                        column('Total Hours', '40:00:00 hrs'),
                        column('Received', '\$800'),
                        column('Paid On', item['paid']!),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}


class PayrollDetailsPage extends StatelessWidget {
  final Map<String, String> month;

  const PayrollDetailsPage({super.key, required this.month});

  Widget row(String label, String value, {Color? color, bool bold = false}) {
    TextStyle style = TextStyle(
      fontSize: bold ? 11 : 9,
      fontWeight: bold ? FontWeight.bold : FontWeight.w500,
      color: color ?? Colors.black,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style.copyWith(fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
          Text(value, style: style),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F3FA),
      appBar: _appBar(context, 'Payroll and Tax'),
      bottomNavigationBar: BottomButtonBar(
        text: 'Save As PDF',
        onPressed: () async {
          await showIconPopup(
            context,
            icon: Icons.file_download,
            title: 'Payroll Saved!',
            text:
            'Your payroll has been successfully saved. You can check it on your device storage.',
            buttons: ['Close Message'],
          );
          if (context.mounted) Navigator.pop(context, true);
        },
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          SummaryCard(
            title: 'Total Working Hour',
            subtitle: 'Paid Period ${month['period']}',
            boxes: const [
              StatBox(label: 'Overtime', value: '00:00 Hrs', dotColor: Colors.grey),
              StatBox(label: 'This Pay Period', value: '40:00 Hrs', dotColor: Colors.grey),
            ],
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Payroll Details',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                const Text('Details about payroll',
                    style: TextStyle(fontSize: 9, color: Colors.grey)),
                const Divider(height: 18, color: Color(0xFFE5E7EB)),
                row('Basic Salary', '\$700.00'),
                row('Tax', '\$70.00-', color: Colors.red),
                row('Reimbursement', '\$70.00+', color: Colors.green),
                row('Bonus', '\$100.00+', color: Colors.green),
                row('Overtime', '\$0.00'),
                const Divider(height: 18, color: Color(0xFFE5E7EB)),
                row('Total Salary', '\$800.00', bold: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
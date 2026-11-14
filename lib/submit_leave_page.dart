import 'package:flutter/material.dart';
import 'my_button.dart';
import 'phone_field.dart';
import 'bottom_button_bar.dart';
import 'bottom_nav.dart';
import 'home_page.dart'; // فيها homeTabNotifier
import 'attendance_pages.dart'; // فيها showIconPopup
import 'create_task_page.dart';

const _purple = Color(0xFF7A5AF8);

const List<String> _months = [
  'January', 'February', 'March', 'April', 'May', 'June',
  'July', 'August', 'September', 'October', 'November', 'December',
];

String _short(int month) {
  String name = _months[month - 1];
  return name == 'September' ? 'Sept' : name.substring(0, 3);
}

String _fullDate(DateTime d) => '${d.day} ${_short(d.month)} ${d.year}';

bool _sameDay(DateTime a, DateTime? b) {
  return b != null && a.year == b.year && a.month == b.month && a.day == b.day;
}


Future<List<DateTime>?> showDateRangeSheet(BuildContext context) {
  return showModalBottomSheet<List<DateTime>>(
    context: context,
    backgroundColor: Colors.white,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (sheetContext) {
      DateTime now = DateTime.now();
      DateTime month = DateTime(now.year, now.month, 1);
      DateTime? start;
      DateTime? end;

      return StatefulBuilder(
        builder: (context, setSheetState) {
          int daysInMonth = DateTime(month.year, month.month + 1, 0).day;
          int offset = DateTime(month.year, month.month, 1).weekday % 7; // الأحد = 0
          int rows = ((offset + daysInMonth) / 7).ceil();

          void tapDay(DateTime day) {
            setSheetState(() {
              if (start == null || end != null) {
                start = day;
                end = null;
              } else if (day.isBefore(start!)) {
                start = day;
              } else {
                end = day;
              }
            });
          }

          Widget dayCell(DateTime day) {
            bool inMonth = day.month == month.month;
            bool isEdge = _sameDay(day, start) || _sameDay(day, end);
            bool isBetween = start != null &&
                end != null &&
                day.isAfter(start!) &&
                day.isBefore(end!);

            return Expanded(
              child: GestureDetector(
                onTap: inMonth ? () => tapDay(day) : null,
                child: Container(
                  height: 34,
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  alignment: Alignment.center,
                  color: isBetween ? const Color(0xFFE4DCFF) : Colors.transparent,
                  child: Container(
                    width: 32,
                    height: 32,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isEdge ? _purple : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${day.day}',
                      style: TextStyle(
                        fontSize: 11,
                        color: isEdge
                            ? Colors.white
                            : inMonth
                            ? Colors.black87
                            : const Color(0xFFB0B5BE),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Leave Duration',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                const Text('Select Leave Duration',
                    style: TextStyle(fontSize: 10.5, color: Color(0xFF6B7280))),
                const SizedBox(height: 10),

                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setSheetState(() {
                          month = DateTime(month.year, month.month - 1, 1);
                        });
                      },
                      child: const Icon(Icons.chevron_left, color: _purple),
                    ),
                    Expanded(
                      child: Center(
                        child: Text('${_months[month.month - 1]} ${month.year}',
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setSheetState(() {
                          month = DateTime(month.year, month.month + 1, 1);
                        });
                      },
                      child: const Icon(Icons.chevron_right, color: _purple),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                Row(
                  children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'].map((name) {
                    return Expanded(
                      child: Container(
                        height: 26,
                        margin: const EdgeInsets.all(1),
                        alignment: Alignment.center,
                        color: const Color(0xFFF3F4F6),
                        child: Text(name, style: const TextStyle(fontSize: 10)),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 4),

                for (int r = 0; r < rows; r++)
                  Row(
                    children: [
                      for (int c = 0; c < 7; c++)
                        dayCell(DateTime(month.year, month.month, r * 7 + c - offset + 1)),
                    ],
                  ),
                const SizedBox(height: 14),

                MyButton(
                  text: 'Submit Date',
                  enabled: start != null,
                  onPressed: () => Navigator.pop(sheetContext, [start!, end ?? start!]),
                ),
                const SizedBox(height: 10),
                MyButton(
                  text: 'Close Message',
                  filled: false,
                  onPressed: () => Navigator.pop(sheetContext),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}


class SubmitLeavePage extends StatefulWidget {
  const SubmitLeavePage({super.key});

  @override
  State<SubmitLeavePage> createState() => _SubmitLeavePageState();
}

class _SubmitLeavePageState extends State<SubmitLeavePage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController descController = TextEditingController();

  String? category;
  String? durationText;
  DateTime? rangeStart;
  DateTime? rangeEnd;
  String? delegation;

  List<String> categories = [
    'Sick Leave',
    'Annual Leave/Vacation Leave',
    'Maternity/Paternity Leave',
    'Bereavement Leave',
    'Personal Leave',
    'Jury Duty Leave',
    'Compassionate Leave',
  ];

  List<String> delegates = [
    'Jeane - UX Writer',
    'Alpheas - UI Designer',
    'John - UX Designer',
    'Alicia - Jr Product Manager',
    'Claudia - UI Designer',
    'Option 4',
    'Option 5',
  ];

  bool get canSubmit {
    return category != null &&
        durationText != null &&
        delegation != null &&
        phoneController.text.trim().isNotEmpty &&
        descController.text.trim().isNotEmpty;
  }

  void pickCategory() async {
    String? result = await showOptionSheet(
      context,
      'Leave Category',
      'Select Leave category',
      categories,
      cancelText: 'Close Message',
      selectText: 'Submit Date',
    );
    if (result != null) {
      setState(() {
        category = result;
      });
    }
  }

  void pickDuration() async {
    List<DateTime>? range = await showDateRangeSheet(context);
    if (range != null) {
      setState(() {
        rangeStart = range[0];
        rangeEnd = range[1];
        durationText = '${_fullDate(range[0])} - ${_fullDate(range[1])}';
      });
    }
  }

  void pickDelegate() async {
    String? result = await showOptionSheet(
      context,
      'Select Task Delegation',
      'Select Leave category',
      delegates,
    );
    if (result != null) {
      setState(() {
        delegation = result;
      });
    }
  }

  void submit() async {
    int? answer = await showIconPopup(
      context,
      icon: Icons.layers,
      title: 'Submit Leave',
      text:
      'Double-check your leave details to ensure everything is correct. Do you want to proceed?',
      buttons: ['Yes, Submit', 'No, Let me check'],
    );
    if (answer != 0 || !mounted) return;

    await showIconPopup(
      context,
      icon: Icons.layers,
      title: 'Leave Submitted!',
      text:
      'Your leave request has been sent for review! Wait for HR to review your request.',
      buttons: ['View Expense History'],
    );
    if (!mounted) return;

    DateTime start = rangeStart!;
    DateTime end = rangeEnd!;
    int diff = end.difference(start).inDays;
    int days = diff == 0 ? 1 : diff;
    DateTime now = DateTime.now();

    Navigator.pop(context, <String, String>{
      'date': '${now.day} ${_months[now.month - 1]} ${now.year}',
      'leaveDate': '${start.day} ${_short(start.month)} - ${end.day} ${_short(end.month)}',
      'days': days == 1 ? '1 Day' : '$days Days',
    });
  }

  OutlineInputBorder border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color),
    );
  }

  Widget selectField(
      String label, IconData icon, String hint, String? value, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF374151))),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 46,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFD9D3F5)),
              ),
              child: Row(
                children: [
                  Icon(icon, size: 18, color: _purple),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      value ?? hint,
                      style: TextStyle(
                        fontSize: 12,
                        color: value == null ? const Color(0xFF374151) : Colors.black,
                      ),
                    ),
                  ),
                  const Icon(Icons.keyboard_arrow_down, color: _purple),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F3FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(12),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const CircleAvatar(
              radius: 14,
              backgroundColor: Color(0xFFEDE9FE),
              child: Icon(Icons.arrow_back_ios_new, size: 12, color: _purple),
            ),
          ),
        ),
        title: const Text('Submit Leave',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ),

      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomButtonBar(text: 'Submit Now', enabled: canSubmit, onPressed: submit),
          MyBottomNav(
            currentIndex: 4,
            onTap: (index) {
              homeTabNotifier.value = index;
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),

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
                const Text('Fill Leave Information',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                const Text('Information about leave details',
                    style: TextStyle(fontSize: 9, color: Colors.grey)),
                const SizedBox(height: 12),

                selectField('Leave Category', Icons.post_add, 'Select Category',
                    category, pickCategory),
                selectField('Leave Duration', Icons.calendar_month, 'Select Duration',
                    durationText, pickDuration),
                selectField('Task Delegation', Icons.account_circle, 'Select Category',
                    delegation, pickDelegate),

                PhoneField(
                  controller: phoneController,
                  label: 'Emergency Contact During Leave Period',
                  hint: '+62 82150005000',
                  onChanged: (value) {
                    setState(() {});
                  },
                ),

                const Text('Leave Description',
                    style: TextStyle(fontSize: 12, color: Color(0xFF374151))),
                const SizedBox(height: 6),
                TextField(
                  controller: descController,
                  maxLines: 4,
                  style: const TextStyle(fontSize: 12),
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter Leave Description',
                    hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
                    border: border(const Color(0xFFD9D3F5)),
                    enabledBorder: border(const Color(0xFFD9D3F5)),
                    focusedBorder: border(_purple),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
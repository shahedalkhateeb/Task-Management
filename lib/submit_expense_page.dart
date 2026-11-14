import 'package:flutter/material.dart';
import 'app_image.dart';
import 'my_text_field.dart';
import 'bottom_button_bar.dart';
import 'attendance_pages.dart'; // فيها showIconPopup
import 'create_task_page.dart';

const _purple = Color(0xFF7A5AF8);

class _DashedBorder extends CustomPainter {
  final Color color;

  _DashedBorder({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(10)));

    for (var metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        canvas.drawPath(metric.extractPath(distance, distance + 4), paint);
        distance += 7;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}


class SubmitExpensePage extends StatefulWidget {
  const SubmitExpensePage({super.key});

  @override
  State<SubmitExpensePage> createState() => _SubmitExpensePageState();
}

class _SubmitExpensePageState extends State<SubmitExpensePage> {
  TextEditingController amountController = TextEditingController();
  TextEditingController descController = TextEditingController();

  int uploadState = 0;
  String? category;
  String? dateText;

  List<String> categories = [
    'Business Trip',
    'Office Supplies',
    'Meals and Entertainment',
    'Professional Development',
    'Home Office Expenses',
    'Mileage Reimbursement',
    'Miscellaneous Expenses',
  ];

  List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];

  bool get canSubmit {
    return uploadState == 2 &&
        category != null &&
        dateText != null &&
        amountController.text.trim().isNotEmpty &&
        descController.text.trim().isNotEmpty;
  }

  void upload() async {
    setState(() {
      uploadState = 1;
    });
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;
    if (uploadState == 1) {
      setState(() {
        uploadState = 2;
      });
    }
  }

  void pickCategory() async {
    String? result = await showOptionSheet(
      context,
      'Expense Category',
      'Select Expense Category',
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

  void pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        dateText = '${picked.day} ${months[picked.month - 1]} ${picked.year}';
      });
    }
  }

  void submit() async {
    int? answer = await showIconPopup(
      context,
      icon: Icons.receipt_long,
      title: 'Ready to Submit?',
      text:
      'Double-check your expense details to ensure everything is correct. Do you want to proceed?',
      buttons: ['Yes, Submit', 'No, Let me check'],
    );
    if (answer != 0 || !mounted) return;

    await showIconPopup(
      context,
      icon: Icons.receipt_long,
      title: 'Expense Submitted!',
      text:
      "Your expense report is in! You'll receive your reimbursement with your payroll.",
      buttons: ['View Expense History'],
    );
    if (!mounted) return;

    Navigator.pop(context, <String, String>{
      'date': dateText!,
      'type': category!,
      'amount': '\$${amountController.text.trim()}',
    });
  }

  OutlineInputBorder border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color),
    );
  }

  Widget closeButton() {
    return Positioned(
      top: 6,
      right: 6,
      child: GestureDetector(
        onTap: () {
          setState(() {
            uploadState = 0;
          });
        },
        child: Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Icon(Icons.close, size: 11, color: Colors.white),
        ),
      ),
    );
  }

  Widget uploadArea() {
    const dashColor = Color(0xFFB9A8FF);

    if (uploadState == 2) {
      return Stack(
        children: [
          CustomPaint(
            painter: _DashedBorder(color: dashColor),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AppImage('assets/images/receipt.png',
                    width: double.infinity, height: 190, fit: BoxFit.cover),
              ),
            ),
          ),
          closeButton(),
        ],
      );
    }

    if (uploadState == 1) {
      return Stack(
        children: [
          CustomPaint(
            painter: _DashedBorder(color: dashColor),
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFFF4F1FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 34,
                    height: 34,
                    child: Stack(
                      alignment: Alignment.center,
                      children: const [
                        SizedBox(
                          width: 34,
                          height: 34,
                          child: CircularProgressIndicator(
                            value: 0.8,
                            strokeWidth: 3,
                            color: _purple,
                            backgroundColor: Color(0xFFE5E1F5),
                          ),
                        ),
                        Text('80%', style: TextStyle(fontSize: 8, color: _purple)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text('Uploading File...',
                      style: TextStyle(fontSize: 8, color: _purple)),
                ],
              ),
            ),
          ),
          closeButton(),
        ],
      );
    }

    return GestureDetector(
      onTap: upload,
      child: CustomPaint(
        painter: _DashedBorder(color: dashColor),
        child: Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            color: const Color(0xFFF4F1FF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.upload_file, size: 20, color: _purple),
              SizedBox(height: 6),
              Text('Upload Claim Document',
                  style: TextStyle(fontSize: 10, color: _purple, fontWeight: FontWeight.w500)),
              SizedBox(height: 2),
              Text('Format should be in .pdf .jpeg .png less than 5MB',
                  style: TextStyle(fontSize: 7, color: Colors.grey)),
            ],
          ),
        ),
      ),
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
                        color: value == null ? Colors.grey : Colors.black,
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
        title: const Text('Submit Expense',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ),
      bottomNavigationBar: BottomButtonBar(
        text: 'Submit Expense',
        enabled: canSubmit,
        onPressed: submit,
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 105),
              child: AppImage('assets/images/expense_banner.png',
                  width: double.infinity, fit: BoxFit.fitWidth),
            ),
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
                const Text('Fill Claim Information',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                const Text('Information about claim details',
                    style: TextStyle(fontSize: 9, color: Colors.grey)),
                const SizedBox(height: 12),

                uploadArea(),
                const SizedBox(height: 14),

                selectField('Expense Category', Icons.post_add, 'Select Category',
                    category, pickCategory),
                selectField('Transaction Date', Icons.calendar_month,
                    'Enter Transaction Date', dateText, pickDate),

                MyTextField(
                  label: 'Expense Amount (\$USD)',
                  hint: 'Enter Amount',
                  icon: Icons.payments_outlined,
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),

                const Text('Expense Description',
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
                    hintText: 'Enter Expense Description',
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
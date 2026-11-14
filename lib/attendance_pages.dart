import 'package:flutter/material.dart';
import 'app_image.dart';
import 'my_button.dart';
import 'bottom_button_bar.dart';

const _purple = Color(0xFF7A5AF8);
const _bg = Color(0xFFF4F3FA);


Future<int?> showIconPopup(
    BuildContext context, {
      required IconData icon,
      required String title,
      required String text,
      required List<String> buttons,
      Widget? extra,
    }) {
  return showModalBottomSheet<int>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (sheetContext) {
      return Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 32),
            padding: const EdgeInsets.fromLTRB(24, 44, 24, 28),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(text,
                      style: const TextStyle(fontSize: 10.5, color: Color(0xFF4B5563))),
                ),
                if (extra != null) ...[
                  const SizedBox(height: 14),
                  extra,
                ],
                const SizedBox(height: 16),
                ...List.generate(buttons.length, (i) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: MyButton(
                      text: buttons[i],
                      filled: i == 0,
                      onPressed: () => Navigator.pop(sheetContext, i),
                    ),
                  );
                }),
              ],
            ),
          ),
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: _purple,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(color: Color(0x557A5AF8), blurRadius: 16, offset: Offset(0, 8)),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
        ],
      );
    },
  );
}

Widget _backButton(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.pop(context),
    child: const CircleAvatar(
      radius: 14,
      backgroundColor: Color(0xFFEDE9FE),
      child: Icon(Icons.arrow_back_ios_new, size: 12, color: _purple),
    ),
  );
}

// صورة السيلفي مع الإحداثيات فوقها (وزر اختياري تحتها)
Widget _selfieCard(double height, {Widget? bottomWidget}) {
  return Stack(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: AppImage('assets/images/selfie.png',
            width: double.infinity, height: height, fit: BoxFit.cover),
      ),
      Positioned.fill(
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black54],
              stops: [0.5, 1.0],
            ),
          ),
        ),
      ),
      Positioned(
        left: 12,
        bottom: bottomWidget != null ? 66 : 12,
        child: const Text(
          'Lat : 45.43534\nLong : 97897.576\n11/10/24 09:00AM GMT +07:00',
          style: TextStyle(fontSize: 9, color: Colors.white),
        ),
      ),
      if (bottomWidget != null)
        Positioned(left: 12, right: 12, bottom: 12, child: bottomWidget),
    ],
  );
}


class ClockInAreaPage extends StatelessWidget {
  const ClockInAreaPage({super.key});

  Widget scheduleBox(String label, String time) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Column(
          children: [
            Text(label, style: const TextStyle(fontSize: 8, color: Colors.grey)),
            const SizedBox(height: 4),
            Text(time, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double top = MediaQuery.of(context).padding.top;
    double width = MediaQuery.of(context).size.width;
    double mapHeight = 380; // طول الخريطة
    double circleSize = width * 0.52; // حجم الدائرة
    double centerY = mapHeight * 0.57; // مكان مركز الدائرة

    return Scaffold(
      backgroundColor: _bg,
      bottomNavigationBar: BottomButtonBar(
        text: 'Selfie To Clock In',
        onPressed: () async {
          bool? done = await Navigator.push<bool>(
            context,
            MaterialPageRoute(builder: (context) => const SelfieCameraPage()),
          );
          if (done == true && context.mounted) Navigator.pop(context, true);
        },
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Stack(
            children: [
              AppImage('assets/images/clockin_map.png',
                  width: double.infinity,
                  height: mapHeight,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter),

              Positioned(
                top: centerY - circleSize / 2,
                left: (width - circleSize) / 2,
                child: AppImage('assets/images/clockin_circle.png',
                    width: circleSize, height: circleSize),
              ),

              Positioned(top: top + 8, left: 12, child: _backButton(context)),
              Positioned(
                top: top + 10,
                left: 0,
                right: 0,
                child:  Center(
                  child: Text('Clock In Area',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: _purple,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child:  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('You are in the clock-in area!',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 2),
                            Text('Now you can press clock in in this area',
                                style: TextStyle(color: Colors.white70, fontSize: 9)),
                          ],
                        ),
                      ),
                      AppImage('assets/images/clockin_header.png', width: 60, height: 50),
                    ],
                  ),
                ),
                 SizedBox(height: 16),

                 Text('MY PROFILE',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                 SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child:  AppImage('assets/images/profile.png',
                            width: 50, height: 50, fit: BoxFit.cover),
                      ),
                       SizedBox(width: 10),
                       Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('Tonald Drump',
                                  style: TextStyle(
                                      fontSize: 12, fontWeight: FontWeight.bold)),
                              SizedBox(width: 4),
                              Icon(Icons.verified, size: 13, color: _purple),
                            ],
                          ),
                          SizedBox(height: 2),
                          Text('29 September 2024',
                              style: TextStyle(fontSize: 10, color: _purple)),
                          SizedBox(height: 2),
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 10, color: _purple),
                              SizedBox(width: 3),
                              Text('Lat 45.43534 Long 97897.576',
                                  style: TextStyle(fontSize: 9, color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                 SizedBox(height: 16),

                 Text('SCHEDULE',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                 SizedBox(height: 8),
                Row(
                  children: [
                    scheduleBox('CLOCK IN', '09:00'),
                     SizedBox(width: 10),
                    scheduleBox('CLOCK OUT', '05:00'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SelfieCameraPage extends StatelessWidget {
  const SelfieCameraPage({super.key});

  Widget darkCircle(Widget child) {
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: const BoxDecoration(color: Color(0xFF2A2A2A), shape: BoxShape.circle),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            color: const Color(0xFF2A2A2A),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    const Icon(Icons.flash_off, color: Colors.white, size: 20),
                    const Expanded(
                      child: Center(
                        child: Text('Camera',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close, color: Colors.white, size: 22),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Expanded(
            child: Stack(
              children: [
                SizedBox.expand(
                  child: AppImage('assets/images/selfie.png', fit: BoxFit.cover),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      darkCircle(const Text('2x',
                          style: TextStyle(color: Colors.white, fontSize: 11))),
                      GestureDetector(
                        onTap: () async {
                          bool? done = await Navigator.push<bool>(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SelfieDetailPage()),
                          );
                          if (done == true && context.mounted) {
                            Navigator.pop(context, true);
                          }
                        },
                        child: Container(
                          width: 66,
                          height: 66,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                          child: const DecoratedBox(
                            decoration: BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                          ),
                        ),
                      ),
                      darkCircle(const Icon(Icons.flash_on, color: Colors.white, size: 18)),
                    ],
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

class SelfieDetailPage extends StatelessWidget {
  const SelfieDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(12),
          child: _backButton(context),
        ),
        title: const Text('Selfie To Clock In',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ),
      bottomNavigationBar: BottomButtonBar(
        text: 'Clock In',
        onPressed: () async {
          await showIconPopup(
            context,
            icon: Icons.person,
            title: 'Clock-In Successful!',
            text:
            "You're all set! Your clock-in was successful. Head over to your dashboard to see your assigned tasks.",
            buttons: ['Go To Clock In Page'],
          );
          if (context.mounted) Navigator.pop(context, true);
        },
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _selfieCard(
                  300,
                  bottomWidget: MyButton(
                    text: 'Retake Photo',
                    icon: Icons.refresh,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(height: 14),
                const Text('Clock In Notes (Optional)',
                    style: TextStyle(fontSize: 10, color: Color(0xFF374151))),
                const SizedBox(height: 6),
                TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Clock-in Notes',
                    hintStyle: const TextStyle(fontSize: 11, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFFD9D3F5)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFFD9D3F5)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: _purple),
                    ),
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

class AttendanceDetailsPage extends StatelessWidget {
  final Map<String, String> record;

  const AttendanceDetailsPage({super.key, required this.record});

  Widget pair(String label1, String value1, String label2, String value2) {
    Widget item(String label, String value) {
      return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 9, color: Colors.grey)),
            const SizedBox(height: 2),
            Text(value, style: const TextStyle(fontSize: 11)),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(children: [item(label1, value1), item(label2, value2)]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(12),
          child: _backButton(context),
        ),
        title:  Text('Details',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ),
      bottomNavigationBar: BottomButtonBar(
        text: 'Export As PDF',
        onPressed: () {
          showIconPopup(
            context,
            icon: Icons.file_download,
            title: 'Export As PDF Successful!',
            text:
            'Your clock-in data has been exported as a PDF. You can now download it.',
            buttons: ['Close Message'],
          );
        },
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Container(
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
                     Icon(Icons.calendar_today, size: 12, color: _purple),
                     SizedBox(width: 6),
                    Text(record['date']!,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
                 SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F7FB),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text('Selfie Clock In',
                          style: TextStyle(fontSize: 9, color: _purple)),
                       SizedBox(height: 6),
                      _selfieCard(220),
                       SizedBox(height: 12),
                       Text('Clock-In Notes',
                          style: TextStyle(fontSize: 9, color: Colors.grey)),
                       SizedBox(height: 2),
                       Text('—', style: TextStyle(fontSize: 11)),
                      pair('Total Hours', record['hours']!, 'Clock in & Out', record['time']!),
                      pair('Break', '01:00:00 hrs', 'Take A Break & Back To Work',
                          '12:00 AM — 01:00 PM'),
                    ],
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
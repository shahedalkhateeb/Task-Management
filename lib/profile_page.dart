import 'package:flutter/material.dart';
import 'app_image.dart';
import 'personal_data_page.dart';
import 'account_pages.dart';
import 'signin_page.dart';
import 'accounts.dart';

const _purple = Color(0xFF7A5AF8);

final ValueNotifier<Map<String, String>> profileNotifier =
ValueNotifier<Map<String, String>>({
  'name': 'Tonald Drump',
  'role': 'Junior Full Stack Developer',
  'avatar': 'assets/images/profile.png',
});

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 6),
      child: Text(text, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
    );
  }

  Widget menuItem(IconData icon, String text, VoidCallback onTap,
      {Color color = _purple}) {
    return ListTile(
      dense: true,
      visualDensity: VisualDensity.compact,
      leading: Icon(icon, size: 16, color: color),
      title: Text(text, style: const TextStyle(fontSize: 10)),
      trailing: const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget infoItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 14, color: _purple),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(fontSize: 10)),
        ],
      ),
    );
  }

  Widget group(List<Widget> items) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: items),
    );
  }

  void open(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    double top = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      body: ValueListenableBuilder<Map<String, String>>(
        valueListenable: profileNotifier,
        builder: (context, profile, child) {
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                width: double.infinity,
                height: top + 175,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: top + 135,
                      color: _purple,
                    ),
                    Positioned(
                      top: top + 110,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 65,
                        decoration:  BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                        ),
                      ),
                    ),
                    Positioned(
                      top: top + 10,
                      left: 16,
                      right: 16,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child:  CircleAvatar(
                              radius: 14,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.arrow_back_ios_new, size: 12, color: _purple),
                            ),
                          ),
                           Expanded(
                            child: Center(
                              child: Text('My Profile',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                           SizedBox(width: 28),
                        ],
                      ),
                    ),
                    Positioned(
                      top: top + 52,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(11),
                            child: AppImage(profile['avatar']!,
                                width: 84, height: 84, fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(profile['name']!,
                              style:  TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                           SizedBox(width: 4),
                           Icon(Icons.verified, size: 15, color: _purple),
                        ],
                      ),
                    ),
                     SizedBox(height: 2),
                    Center(
                      child: Text(profile['role']!,
                          style:  TextStyle(fontSize: 10, color: _purple)),
                    ),

                    sectionTitle('CONTACT'),
                    group([
                      const SizedBox(height: 4),
                      infoItem(Icons.email, currentAccount?.email ?? 'Tonald@gmail.com'),
                      infoItem(Icons.verified_user, 'Taman Anggrek'),
                      const SizedBox(height: 4),
                    ]),

                    sectionTitle('ACCOUNT'),
                    group([
                      menuItem(Icons.person, 'Personal Data',
                              () => open(context, const PersonalDataPage())),
                      menuItem(Icons.folder, 'Office Assets',
                              () => open(context, const OfficeAssetsPage())),
                      menuItem(Icons.payments, 'Payroll & Tax',
                              () => open(context, const PayrollPage())),
                    ]),

                    sectionTitle('SETTINGS'),
                    group([
                      menuItem(Icons.settings, 'Change Password', () {}),
                      menuItem(Icons.code, 'Versioning', () {}),
                      menuItem(Icons.chat, 'FAQ and Help', () {}),
                      menuItem(Icons.logout, 'Logout', () {
                        currentAccount = null;
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const SignInPage()),
                              (route) => false,
                        );
                      }, color: Colors.red),
                    ]),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
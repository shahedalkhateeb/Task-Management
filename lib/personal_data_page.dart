import 'package:flutter/material.dart';
import 'app_image.dart';
import 'my_text_field.dart';
import 'bottom_button_bar.dart';
import 'attendance_pages.dart'; // فيها showIconPopup
import 'create_task_page.dart'; // فيها showOptionSheet
import 'profile_page.dart';

const _purple = Color(0xFF7A5AF8);

class PersonalDataPage extends StatefulWidget {
  const PersonalDataPage({super.key});

  @override
  State<PersonalDataPage> createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends State<PersonalDataPage> {
  TextEditingController firstController = TextEditingController();
  TextEditingController lastController = TextEditingController();
  TextEditingController addressController = TextEditingController(
      text: 'Jl Mampang Prapatan XIV No 7A, Jakarta Selatan 12790');

  late String avatar;
  String dob = '10 December 1997';
  late String position;
  String country = 'Indonesia';
  String state = 'DKI Jakarta';
  String city = 'Jakarta Selatan';

  List<String> avatars = [
    'assets/images/profile.png',
    'assets/images/profile_alt.png',
  ];

  List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];

  List<String> positions = [
    'Junior Full Stack Developer',
    'Sr Front End Developer',
    'Mid Front End Developer',
    'Jr Front End Developer',
    'UI Designer',
    'UX Designer',
    'Product Manager',
  ];
  List<String> countries = ['Indonesia', 'Palestine', 'Jordan'];
  List<String> states = ['DKI Jakarta', 'West Java', 'Central Java'];
  List<String> cities = ['Jakarta Selatan', 'Jakarta Pusat', 'Bandung'];

  @override
  void initState() {
    super.initState();
    Map<String, String> profile = profileNotifier.value;
    List<String> nameParts = profile['name']!.split(' ');
    firstController.text = nameParts[0];
    lastController.text = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';
    position = profile['role']!;
    avatar = profile['avatar']!;
  }

  void changeAvatar() {
    setState(() {
      avatar = avatar == avatars[0] ? avatars[1] : avatars[0];
    });
  }

  void pickDob() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1997, 12, 10),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        dob = '${picked.day} ${months[picked.month - 1]} ${picked.year}';
      });
    }
  }

  void pickPosition() async {
    String? result =
    await showOptionSheet(context, 'Position', 'Select position', positions);
    if (result != null) {
      setState(() {
        position = result;
      });
    }
  }

  void pickCountry() async {
    String? result =
    await showOptionSheet(context, 'Country', 'Select country', countries);
    if (result != null) {
      setState(() {
        country = result;
      });
    }
  }

  void pickState() async {
    String? result = await showOptionSheet(context, 'State', 'Select state', states);
    if (result != null) {
      setState(() {
        state = result;
      });
    }
  }

  void pickCity() async {
    String? result = await showOptionSheet(context, 'City', 'Select city', cities);
    if (result != null) {
      setState(() {
        city = result;
      });
    }
  }

  void update() async {
    int? answer = await showIconPopup(
      context,
      icon: Icons.person,
      title: 'Update Profile',
      text:
      'Are you sure you want to update your profile? This will help us improve your experience and provide personalized features.',
      buttons: ['Yes, Update Profile', 'No, Let me check'],
    );
    if (answer != 0 || !mounted) return;

    await showIconPopup(
      context,
      icon: Icons.person,
      title: 'Profile Updated!',
      text:
      "Your profile has been successfully updated. We're excited to see you take this step!",
      buttons: ['View My Profile'],
    );
    if (!mounted) return;

    String name = '${firstController.text.trim()} ${lastController.text.trim()}'.trim();
    profileNotifier.value = {
      'name': name.isEmpty ? 'Tonald Drump' : name,
      'role': position,
      'avatar': avatar,
    };
    Navigator.pop(context);
  }

  OutlineInputBorder border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color),
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
          padding:  EdgeInsets.all(12),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child:  CircleAvatar(
              radius: 14,
              backgroundColor: Color(0xFFEDE9FE),
              child: Icon(Icons.arrow_back_ios_new, size: 12, color: _purple),
            ),
          ),
        ),
        title:  Text('Personal Data',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ),
      bottomNavigationBar: BottomButtonBar(text: 'Update', onPressed: update),
      body: ListView(
        padding:  EdgeInsets.all(12),
        children: [
          Container(
            padding:  EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text('My Personal Data',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                 Text('Details about my personal data',
                    style: TextStyle(fontSize: 9, color: Colors.grey)),
                 SizedBox(height: 12),

                Center(
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: AppImage(avatar,
                                width: 80, height: 80, fit: BoxFit.cover),
                          ),
                          Positioned(
                            top: -8,
                            right: -8,
                            child: GestureDetector(
                              onTap: changeAvatar,
                              child:  CircleAvatar(
                                radius: 11,
                                backgroundColor: _purple,
                                child: Icon(Icons.sync, size: 12, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                       SizedBox(height: 8),
                       Text('Upload Photo', style: TextStyle(fontSize: 9)),
                       Text(
                        'Format should be in .jpeg .png atleast\n800×800px and less than 5MB',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 7, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                 SizedBox(height: 16),

                MyTextField(
                  label: 'First Name',
                  hint: 'Enter First Name',
                  icon: Icons.person_outline,
                  controller: firstController,
                ),
                MyTextField(
                  label: 'Last Name',
                  hint: 'Enter Last Name',
                  icon: Icons.person_outline,
                  controller: lastController,
                ),
                MySelectField(
                  label: 'Date of Birth',
                  icon: Icons.calendar_month,
                  value: dob,
                  onTap: pickDob,
                ),
                MySelectField(
                  label: 'Position',
                  icon: Icons.badge_outlined,
                  value: position,
                  onTap: pickPosition,
                ),
              ],
            ),
          ),
           SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text('Address',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                 Text('Your current domicile',
                    style: TextStyle(fontSize: 9, color: Colors.grey)),
                 SizedBox(height: 12),

                MySelectField(
                  label: 'Country',
                  icon: Icons.verified_user_outlined,
                  value: country,
                  onTap: pickCountry,
                ),
                MySelectField(
                  label: 'State',
                  icon: Icons.verified_user_outlined,
                  value: state,
                  onTap: pickState,
                ),
                MySelectField(
                  label: 'City',
                  icon: Icons.verified_user_outlined,
                  value: city,
                  onTap: pickCity,
                ),

                 Text('Full Address',
                    style: TextStyle(fontSize: 12, color: Color(0xFF374151))),
                 SizedBox(height: 6),
                TextField(
                  controller: addressController,
                  maxLines: 5,
                  style:  TextStyle(fontSize: 12),
                  decoration: InputDecoration(
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
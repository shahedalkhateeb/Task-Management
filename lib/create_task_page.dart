import 'package:flutter/material.dart';
import 'app_image.dart';
import 'my_button.dart';
import 'my_text_field.dart';
import 'bottom_button_bar.dart';
import 'attendance_pages.dart';

const _purple = Color(0xFF7A5AF8);


Future<String?> showOptionSheet(
    BuildContext context,
    String title,
    String subtitle,
    List<String> options, {
      String cancelText = 'Cancel',
      String selectText = 'Select',
    }) {
  return showModalBottomSheet<String>(
    context: context,
    backgroundColor: Colors.white,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (sheetContext) {
      String? selected;

      return StatefulBuilder(
        builder: (context, setSheetState) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style:  TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                 SizedBox(height: 2),
                Text(subtitle,
                    style:  TextStyle(fontSize: 10.5, color: Color(0xFF6B7280))),
                 SizedBox(height: 16),

                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      children: options.map((option) {
                        bool isSelected = option == selected;
                        return GestureDetector(
                          onTap: () {
                            setSheetState(() {
                              selected = option;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFFF1EDFF) : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isSelected ? _purple : const Color(0xFFD9D3F5),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(option, style:  TextStyle(fontSize: 12)),
                                ),
                                isSelected
                                    ? Container(
                                  width: 20,
                                  height: 20,
                                  decoration:  BoxDecoration(
                                      color: _purple, shape: BoxShape.circle),
                                  child:  Icon(Icons.check,
                                      size: 13, color: Colors.white),
                                )
                                    : Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: const Color(0xFF9CA3AF)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: MyButton(
                        text: cancelText,
                        filled: false,
                        onPressed: () => Navigator.pop(sheetContext),
                      ),
                    ),
                     SizedBox(width: 12),
                    Expanded(
                      child: MyButton(
                        text: selectText,
                        enabled: selected != null,
                        onPressed: () => Navigator.pop(sheetContext, selected),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  String? assignee;
  String? priority;
  String? difficulty;

  List<int> slots = [0, 0, 0];

  List<String> photos = [
    'assets/images/task_photo1.png',
    'assets/images/task_photo2.png',
    'assets/images/task_photo3.png',
  ];
  List<String> percents = ['75%', '50%', '25%'];

  List<String> members = [
    'Ivankov - Sr Front End Developer',
    'Brahm - Mid Front End Developer',
    'Alice - Sr Front End Developer',
    'Jeane - Jr Front End Developer',
    'Claudia - Jr Front End Developer',
  ];
  List<String> priorities = ['Low', 'Medium', 'High'];
  List<String> difficulties = [
    'Very Easy (Less Than a Day)',
    'Easy (A Day)',
    'Moderate (3 Days)',
    'Intermediate (5 Days)',
    'Advanced (1 Week)',
  ];

  bool get canCreate {
    return titleController.text.trim().isNotEmpty &&
        descController.text.trim().isNotEmpty &&
        assignee != null &&
        priority != null &&
        difficulty != null;
  }

  void upload(int i) async {
    setState(() {
      slots[i] = 1;
    });
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() {
      slots[i] = 2;
    });
  }

  void pickAssignee() async {
    String? result = await showOptionSheet(
        context, 'Assign To', 'Who will finish this task', members);
    if (result != null) {
      setState(() {
        assignee = result;
      });
    }
  }

  void pickPriority() async {
    String? result =
    await showOptionSheet(context, 'Priority', 'Select the priority', priorities);
    if (result != null) {
      setState(() {
        priority = result;
      });
    }
  }

  void pickDifficulty() async {
    String? result = await showOptionSheet(
        context, 'Difficulty', 'Select the difficulty', difficulties);
    if (result != null) {
      setState(() {
        difficulty = result;
      });
    }
  }

  void createTask() async {
    int? answer = await showIconPopup(
      context,
      icon: Icons.event_note,
      title: 'Create New Task',
      text:
      'Double-check your task details to ensure everything is correct. Do you want to proceed?',
      buttons: ['Yes, Proceed Now', 'No, Let me check'],
    );
    if (answer != 0 || !mounted) return;

    await showIconPopup(
      context,
      icon: Icons.event_note,
      title: 'Task Has Been Created!',
      text:
      'Congratulations! Task has been created! view your task in the task management',
      buttons: ['View Task Management'],
    );
    if (!mounted) return;

    List<String> uploaded = [];
    for (int i = 0; i < 3; i++) {
      if (slots[i] == 2) uploaded.add(photos[i]);
    }

    Navigator.pop(context, <String, dynamic>{
      'title': titleController.text.trim(),
      'description': descController.text.trim(),
      'assignee': assignee,
      'priority': priority,
      'difficulty': difficulty,
      'images': uploaded,
    });
  }

  OutlineInputBorder border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color),
    );
  }

  Widget slot(int i) {
    Widget child;

    if (slots[i] == 0) {
      child = Container(
        height: 78,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFFF4F1FF),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFD9D3F5)),
        ),
        child:  Icon(Icons.upload_outlined, color: _purple, size: 20),
      );
    } else if (slots[i] == 1) {
      child = Container(
        height: 78,
        decoration: BoxDecoration(
          color: const Color(0xFFF4F1FF),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _purple),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(percents[i], style:  TextStyle(fontSize: 16, color: _purple)),
             Text('Uploading...', style: TextStyle(fontSize: 6, color: _purple)),
          ],
        ),
      );
    } else {
      child = Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: AppImage(photos[i],
                width: double.infinity, height: 78, fit: BoxFit.cover),
          ),
          Positioned(
            top: -4,
            right: -4,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  slots[i] = 0;
                });
              },
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                child:  Icon(Icons.close, size: 10, color: Colors.white),
              ),
            ),
          ),
        ],
      );
    }

    return Expanded(
      child: GestureDetector(
        onTap: slots[i] == 0 ? () => upload(i) : null,
        child: child,
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
          Text(label, style:  TextStyle(fontSize: 12, color: Color(0xFF374151))),
           SizedBox(height: 6),
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 46,
              padding:  EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFD9D3F5)),
              ),
              child: Row(
                children: [
                  Icon(icon, size: 18, color: _purple),
                   SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      value ?? hint,
                      style: TextStyle(
                        fontSize: 12,
                        color: value == null ? const Color(0xFF374151) : Colors.black,
                      ),
                    ),
                  ),
                   Icon(Icons.keyboard_arrow_down, color: _purple),
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
            child:  CircleAvatar(
              radius: 14,
              backgroundColor: Color(0xFFEDE9FE),
              child: Icon(Icons.arrow_back_ios_new, size: 12, color: _purple),
            ),
          ),
        ),
        title:  Text('Create New Task',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ),
      bottomNavigationBar: BottomButtonBar(
        text: 'Create Task',
        enabled: canCreate,
        onPressed: createTask,
      ),
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
                 Text('Attachment',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                 Text('Format should be in .pdf .jpeg .png less than 5MB',
                    style: TextStyle(fontSize: 9, color: Colors.grey)),
                 SizedBox(height: 10),
                Row(
                  children: [
                    slot(0),
                     SizedBox(width: 8),
                    slot(1),
                     SizedBox(width: 8),
                    slot(2),
                  ],
                ),
                 SizedBox(height: 14),

                MyTextField(
                  label: 'Task Title',
                  hint: 'Enter Task Title',
                  icon: Icons.post_add,
                  controller: titleController,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),

                 Text('Task Description',
                    style: TextStyle(fontSize: 12, color: Color(0xFF374151))),
                 SizedBox(height: 6),
                TextField(
                  controller: descController,
                  maxLines: 4,
                  style:  TextStyle(fontSize: 12),
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter Task Description',
                    hintStyle:  TextStyle(fontSize: 12, color: Colors.grey),
                    border: border( Color(0xFFD9D3F5)),
                    enabledBorder: border( Color(0xFFD9D3F5)),
                    focusedBorder: border(_purple),
                  ),
                ),
                 SizedBox(height: 14),

                selectField('Assign To', Icons.account_circle, 'Select Member',
                    assignee, pickAssignee),
                selectField(
                    'Priority', Icons.layers, 'Select Priority', priority, pickPriority),
                selectField('Difficulty', Icons.data_usage, 'Select Difficulty',
                    difficulty, pickDifficulty),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
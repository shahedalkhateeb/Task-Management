import 'package:flutter/material.dart';
import 'app_image.dart';
import 'bottom_nav.dart';
import 'home_page.dart';

const _purple = Color(0xFF7A5AF8);


class TaskDetailsPage extends StatefulWidget {
  final Map<String, dynamic> task;

  const TaskDetailsPage({super.key, required this.task});

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  late String status;
  late List<String> images;
  late List<Map<String, String>> comments;
  int selectedImage = 0;
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> task = widget.task;

    status = task['status'] as String;

    images = (task['images'] as List<String>?) ??
        [
          'assets/images/task_photo1.png',
          'assets/images/task_photo2.png',
          'assets/images/task_photo3.png',
        ];

    bool isNew = task['new'] == true;
    comments = isNew
        ? []
        : [
      {
        'name': 'Jason',
        'role': 'Product Manager',
        'date': '28 Sept 2024 5:53 AM',
        'text': 'Dude, how long it will take? any blocker? need the update asap',
        'avatar': 'assets/images/avatar_jason.png',
      },
      {
        'name': 'Alice',
        'role': 'Sr Front End Developer',
        'date': '29 Sept 2024 5:53 AM',
        'text': '@Jason still testing, will be push at 04:00 PM',
        'avatar': 'assets/images/avatar_alice.png',
      },
    ];
  }

  String get description =>
      (widget.task['description'] as String?) ??
          'Create on boarding page based on pic, pixel perfect, with the user story of i want to know what kind of apps is this so i need to view onboarding screen to leverage my knowledge so that i know what kind of apps is this';

  String get priority => (widget.task['priority'] as String?) ?? 'High';

  String get difficulty =>
      (widget.task['difficulty'] as String?) ?? 'Very Easy (Less Than a Day)';

  String get assignee =>
      (widget.task['assignee'] as String?) ?? 'Alice - Sr Front End Developer';

  Color get priorityColor {
    if (priority == 'High') return Colors.red;
    if (priority == 'Medium') return Colors.orange;
    return Colors.green;
  }

  void addComment() {
    String text = commentController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      comments.add({
        'name': 'Tonald Drump',
        'role': 'Junior Full Stack Developer',
        'date': 'Just now',
        'text': text,
        'avatar': 'assets/images/profile.png',
      });
      commentController.clear();
    });
  }

  Widget statusChip() {
    bool done = status == 'Done';
    return GestureDetector(
      onTap: () {
        setState(() {
          status = done ? 'In Progress' : 'Done';
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: done ? const Color(0xFFDCFCE7) : const Color(0xFFE5E7EB),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            done
                ? const Icon(Icons.check_circle, size: 10, color: Colors.green)
                : const CircleAvatar(radius: 3, backgroundColor: Colors.grey),
            const SizedBox(width: 4),
            Text(done ? 'Done' : 'In Progress',
                style: TextStyle(fontSize: 9, color: done ? Colors.green : Colors.black87)),
          ],
        ),
      ),
    );
  }

  Widget commentText(String text) {
    const style = TextStyle(fontSize: 10, color: Color(0xFF4B5563));
    if (text.startsWith('@')) {
      int space = text.indexOf(' ');
      if (space > 0) {
        return Text.rich(
          TextSpan(
            style: style,
            children: [
              TextSpan(text: text.substring(0, space), style: const TextStyle(color: _purple)),
              TextSpan(text: text.substring(space)),
            ],
          ),
        );
      }
    }
    return Text(text, style: style);
  }

  Widget commentTile(Map<String, String> comment) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: AppImage(comment['avatar']!, width: 30, height: 30, fit: BoxFit.cover),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(comment['name']!,
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    Text(comment['date']!,
                        style: const TextStyle(fontSize: 8, color: Colors.grey)),
                  ],
                ),
                Text(comment['role']!, style: const TextStyle(fontSize: 9, color: _purple)),
                const SizedBox(height: 4),
                commentText(comment['text']!),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> parts = assignee.split(' - ');
    String assigneeName = parts[0];
    String assigneeRole = parts.length > 1 ? parts[1] : '';
    bool hasComment = commentController.text.trim().isNotEmpty;

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
        title: const Text('Task Details',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ),

      bottomNavigationBar: MyBottomNav(
        currentIndex: 2,
        onTap: (index) {
          homeTabNotifier.value = index;
          Navigator.of(context).popUntil((route) => route.isFirst);
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.task['title'] as String,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 2),
                          const Text('Created 27 Sept 2024',
                              style: TextStyle(fontSize: 9, color: Colors.grey)),
                        ],
                      ),
                    ),
                    statusChip(),
                  ],
                ),
                const SizedBox(height: 10),

                if (images.isNotEmpty) ...[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ImageZoomPage(path: images[selectedImage])),
                      );
                    },
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: AppImage(images[selectedImage],
                              width: double.infinity, height: 160, fit: BoxFit.cover),
                        ),
                        Positioned(
                          bottom: 8,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(images.length, (i) {
                              return Container(
                                margin: const EdgeInsets.symmetric(horizontal: 2),
                                width: i == selectedImage ? 14 : 5,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: i == selectedImage ? _purple : Colors.white70,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  Row(
                    children: [
                      for (int i = 0; i < images.length; i++)
                        if (i != selectedImage)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedImage = i;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: AppImage(images[i],
                                    width: 60, height: 45, fit: BoxFit.cover),
                              ),
                            ),
                          ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Description',
                          style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(description,
                          style: const TextStyle(fontSize: 10.5, color: Color(0xFF4B5563))),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Priority',
                              style: TextStyle(fontSize: 9, color: Colors.grey)),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: priorityColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.flag, size: 10, color: Colors.white),
                                const SizedBox(width: 3),
                                Text(priority,
                                    style: const TextStyle(fontSize: 9, color: Colors.white)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Difficulty',
                              style: TextStyle(fontSize: 9, color: Colors.grey)),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 8,
                                backgroundColor: Color(0xFFDCFCE7),
                                child: Icon(Icons.sentiment_satisfied_alt,
                                    size: 12, color: Colors.green),
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(difficulty, style: const TextStyle(fontSize: 9)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(height: 24, color: Color(0xFFE5E7EB)),

                const Text('Assignee',
                    style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ClipOval(
                      child: const AppImage('assets/images/avatar_alice.png',
                          width: 36, height: 36, fit: BoxFit.cover),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(assigneeName,
                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                        Text(assigneeRole,
                            style: const TextStyle(fontSize: 10, color: _purple)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 14),


                const Text('Comment Section',
                    style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ...comments.map((comment) => commentTile(comment)),

                Row(
                  children: [
                    ClipOval(
                      child: const AppImage('assets/images/profile.png',
                          width: 30, height: 30, fit: BoxFit.cover),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(10, 2, 4, 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4F4F8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: commentController,
                                style: const TextStyle(fontSize: 10),
                                onChanged: (value) {
                                  setState(() {});
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Write a comment...',
                                  hintStyle: TextStyle(fontSize: 10, color: Colors.grey),
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: addComment,
                              child: Container(
                                width: 26,
                                height: 26,
                                decoration: BoxDecoration(
                                  color: hasComment ? _purple : const Color(0xFF9CA3AF),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Icon(Icons.send, size: 12, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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


class ImageZoomPage extends StatelessWidget {
  final String path;

  const ImageZoomPage({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.pop(context),
        child: SizedBox.expand(
          child: Center(
            child: AppImage(path, width: double.infinity, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
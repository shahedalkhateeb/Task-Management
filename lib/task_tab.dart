import 'package:flutter/material.dart';
import 'purple_header.dart';
import 'summary_card.dart';
import 'stat_box.dart';
import 'tab_selector.dart';
import 'task_card.dart';
import 'bottom_button_bar.dart';
import 'create_task_page.dart';
import 'task_details_page.dart';

class TaskTab extends StatefulWidget {
  const TaskTab({super.key});

  @override
  State<TaskTab> createState() => _TaskTabState();
}

class _TaskTabState extends State<TaskTab> {
  int tabIndex = 1;

  List<Map<String, dynamic>> tasks = [
    {'title': 'Wiring Dashboard Analytics', 'status': 'In Progress', 'tab': 1, 'progress': 1.0, 'date': '27 Sept'},
    {'title': 'API Dashboard Analytics Integration', 'status': 'In Progress', 'tab': 1, 'progress': 1.0, 'date': '27 Sept'},
    {'title': 'Slicing Dashboard Analytics', 'status': 'Done', 'tab': 2, 'progress': 1.0, 'date': '27 Sept'},
  ];

  int countOf(int tab) {
    return tasks.where((t) => t['tab'] == tab).length;
  }

  List<Map<String, dynamic>> get shownTasks {
    return tasks.where((t) => t['tab'] == tabIndex).toList();
  }

  void createTask() async {
    Map<String, dynamic>? newTask = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(builder: (context) => const CreateTaskPage()),
    );

    if (newTask != null && mounted) {
      setState(() {
        tasks.insert(0, {
          'title': newTask['title'],
          'status': 'In Progress',
          'tab': 0,
          'progress': 0.5,
          'date': '27 Sept',
          'new': true,
          'description': newTask['description'],
          'priority': newTask['priority'],
          'difficulty': newTask['difficulty'],
          'assignee': newTask['assignee'],
          'images': newTask['images'],
        });
        tabIndex = 0;
      });
    }
  }

  void openDetails(Map<String, dynamic> task) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskDetailsPage(task: task)),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool good = tabIndex == 1;
    Color sprintColor = good ? Colors.green : Colors.deepOrange;

    return Container(
      color: const Color(0xFFF4F3FA),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const PurpleHeader(
                  title: 'Challanges Awaiting',
                  subtitle: "Let's tackle your to do list",
                  imagePath: 'assets/images/task_header.png',
                  card: SummaryCard(
                    title: 'Summary of Your Work',
                    subtitle: 'Your current task progress',
                    boxes: [
                      StatBox(label: 'To Do', value: '5', dotColor: Color(0xFF7A5AF8)),
                      StatBox(label: 'In Progress', value: '2', dotColor: Colors.orange),
                      StatBox(label: 'Done', value: '1', dotColor: Colors.green),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
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
                                const Text('Sprint 20 - Burnout Stats',
                                    style: TextStyle(
                                        fontSize: 12, fontWeight: FontWeight.bold)),
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: good ? Colors.green : Colors.deepOrange,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(good ? 'Good' : 'Poor',
                                      style: const TextStyle(
                                          fontSize: 9, color: Colors.white)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text.rich(
                              TextSpan(
                                style: const TextStyle(
                                    fontSize: 10, color: Color(0xFF6B7280)),
                                children: [
                                  const TextSpan(text: "You've completed "),
                                  TextSpan(
                                    text: good
                                        ? '4 more tasks than usual'
                                        : '8 more tasks than usual',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87),
                                  ),
                                  const TextSpan(
                                      text:
                                      ', maintain your task with your supervisor'),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF7F7FB),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: const Color(0xFFE5E7EB)),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 12,
                                    backgroundColor: good
                                        ? const Color(0xFFDCFCE7)
                                        : const Color(0xFFFFE4DC),
                                    child: Icon(
                                      good
                                          ? Icons.sentiment_very_satisfied
                                          : Icons.sentiment_very_dissatisfied,
                                      size: 16,
                                      color: sprintColor,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: LinearProgressIndicator(
                                        value: good ? 0.25 : 0.85,
                                        minHeight: 4,
                                        color: sprintColor,
                                        backgroundColor: const Color(0xFFE5E7EB),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      TabSelector(
                        labels: const ['To Do', 'In Progress', 'Finish'],
                        counts: [countOf(0), countOf(1), countOf(2)],
                        selected: tabIndex,
                        onChanged: (index) {
                          setState(() {
                            tabIndex = index;
                          });
                        },
                      ),
                      const SizedBox(height: 12),

                      ...shownTasks.map((task) {
                        bool isNew = task['new'] == true;
                        return GestureDetector(
                          onTap: () => openDetails(task),
                          child: TaskCard(
                            title: task['title'] as String,
                            status: task['status'] as String,
                            progress: task['progress'] as double,
                            background: Colors.white,
                            date: task['date'] as String,
                            avatarPath: isNew
                                ? 'assets/images/avatar_alice.png'
                                : 'assets/images/avatars.png',
                            avatarWidth: isNew ? 20 : 50,
                            priority: (task['priority'] as String?) ?? 'High',
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
          BottomButtonBar(text: 'Create Task', onPressed: createTask),
        ],
      ),
    );
  }
}
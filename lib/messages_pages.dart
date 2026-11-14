import 'package:flutter/material.dart';
import 'app_image.dart';
import 'home_page.dart';

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
    title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
  );
}


class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  List<Map<String, dynamic>> chats = [
    {'name': 'Alicia Rochefort', 'avatar': 'assets/images/avatar_alicia.png', 'preview': 'Hey Tonald, we have to attend our daily stand up...', 'unread': 1},
    {'name': 'Jessica Tan', 'avatar': 'assets/images/avatar_jessica.png', 'preview': "Ey Tonald, let's do the design sprint at friday 10.00...", 'unread': 0},
    {'name': 'Lolita Xue', 'avatar': 'assets/images/avatar_lolita.png', 'preview': "Ey Tonald, let's do the design sprint at friday 10.00...", 'unread': 0},
    {'name': 'Eaj Prakk', 'avatar': 'assets/images/avatar_alicia.png', 'preview': "Ey Tonald, let's do the design sprint at friday 10.00...", 'unread': 0},
    {'name': 'Jason', 'avatar': 'assets/images/avatar_jessica.png', 'preview': "Ey Tonald, let's do the design sprint at friday 10.00...", 'unread': 0},
    {'name': 'Kimberly', 'avatar': 'assets/images/avatar_lolita.png', 'preview': "Ey Tonald, let's do the design sprint at friday 10.00...", 'unread': 0},
    {'name': 'Wang', 'avatar': 'assets/images/avatar_alicia.png', 'preview': "Ey Tonald, let's do the design sprint at friday 10.00...", 'unread': 0},
    {'name': 'James', 'avatar': 'assets/images/avatar_jessica.png', 'preview': "Ey Tonald, let's do the design sprint at friday 10.00...", 'unread': 0},
    {'name': 'Bella', 'avatar': 'assets/images/avatar_lolita.png', 'preview': "Ey Tonald, let's do the design sprint at friday 10.00...", 'unread': 0},
  ];

  void openChat(Map<String, dynamic> chat) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(
          name: chat['name'] as String,
          avatar: chat['avatar'] as String,
        ),
      ),
    );

    if (mounted) {
      setState(() {
        chat['unread'] = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F3FA),
      appBar: _appBar(context, 'Messages'),
      body: ListView(
        children: chats.map((chat) {
          int unread = chat['unread'] as int;
          return InkWell(
            onTap: () => openChat(chat),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration:  BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Color(0xFFF0F0F5))),
              ),
              child: Row(
                children: [
                  ClipOval(
                    child: AppImage(chat['avatar'] as String,
                        width: 44, height: 44, fit: BoxFit.cover),
                  ),
                   SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(chat['name'] as String,
                            style:  TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                         SizedBox(height: 4),
                        Text(
                          chat['preview'] as String,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 9, color: Color(0xFF6B7280)),
                        ),
                      ],
                    ),
                  ),
                   SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                       Text('09.10',
                          style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
                       SizedBox(height: 6),
                      if (unread > 0)
                        Container(
                          width: 16,
                          height: 16,
                          alignment: Alignment.center,
                          decoration:  BoxDecoration(
                            color: Color(0xFFFF3B6B),
                            shape: BoxShape.circle,
                          ),
                          child: Text('$unread',
                              style:  TextStyle(fontSize: 9, color: Colors.white)),
                        )
                      else
                         SizedBox(height: 16),
                    ],
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


class ChatPage extends StatefulWidget {
  final String name;
  final String avatar;

  const ChatPage({super.key, required this.name, required this.avatar});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  late List<Map<String, dynamic>> messages;

  List<Map<String, dynamic>> startMessages(String name) {
    if (name == 'Alicia Rochefort') {
      return [
        {'text': 'Hey Tonald, we have to attend our daily stand up', 'time': '09.10', 'mine': false},
        {'text': 'Sure, when will daily stand up starts?', 'time': '09.12', 'mine': true},
        {'text': "It's around 11.00, in the meeting room", 'time': '09.13', 'mine': false},
        {'text': "btw, don't forget bring the sunday report ya", 'time': '09.13', 'mine': false},
        {'text': 'See you there!', 'time': '09.13', 'mine': false},
        {
          'text':
          "Okay Alicia, I'll make sure to attend the daily stand up and make sure everything goes well, and bring the sunday report to you, see you there at 11.00 Alicia!",
          'time': '09.14',
          'mine': true,
        },
      ];
    }

    if (name == 'Jessica Tan') {
      return [
        {'text': 'Hey Tonald, send me picture of our teamwork for IG post', 'time': '09.10', 'mine': false},
        {'text': "Sure, wait, i'll send you", 'time': '09.12', 'mine': true},
        {'image': 'assets/images/chat_photo.png', 'mine': true},
        {'text': 'Thanks Tonald!', 'time': '09.13', 'mine': false},
        {'text': "you're welcome jess!", 'time': '09.14', 'mine': true},
      ];
    }

    return [
      {'text': "Ey Tonald, let's do the design sprint at friday 10.00", 'time': '09.10', 'mine': false},
    ];
  }

  @override
  void initState() {
    super.initState();
    messages = startMessages(widget.name);
    scrollToBottom();
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

  String nowTime() {
    DateTime now = DateTime.now();
    String hour = now.hour.toString().padLeft(2, '0');
    String minute = now.minute.toString().padLeft(2, '0');
    return '$hour.$minute';
  }

  void send() {
    String text = messageController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      messages.add({'text': text, 'time': nowTime(), 'mine': true});
      messageController.clear();
    });
    scrollToBottom();
  }

  Widget bubble(Map<String, dynamic> message) {
    bool mine = message['mine'] as bool;
    double maxWidth = MediaQuery.of(context).size.width * 0.72;

    if (message['image'] != null) {
      return Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AppImage(message['image'] as String,
                width: 195, height: 195, fit: BoxFit.cover),
          ),
        ),
      );
    }

    return Align(
      alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        constraints: BoxConstraints(maxWidth: maxWidth),
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
        decoration: BoxDecoration(
          color: mine ? _purple : Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message['text'] as String,
              style: TextStyle(
                fontSize: 11,
                color: mine ? Colors.white : const Color(0xFF111827),
              ),
            ),
             SizedBox(height: 6),
            Text(
              message['time'] as String,
              style: TextStyle(
                fontSize: 8,
                color: mine ? Colors.white70 : const Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool hasText = messageController.text.trim().isNotEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F7),
      appBar: _appBar(context, widget.name),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              controller: scrollController,
              padding: const EdgeInsets.all(14),
              children: messages.map((message) => bubble(message)).toList(),
            ),
          ),

          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 46,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F4F8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: messageController,
                              style: const TextStyle(fontSize: 12),
                              onChanged: (value) {
                                setState(() {});
                              },
                              onSubmitted: (value) => send(),
                              decoration: const InputDecoration(
                                hintText: 'Type a message...',
                                hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                          const Icon(Icons.attach_file, size: 16, color: Colors.grey),
                          const SizedBox(width: 10),
                          const Icon(Icons.photo_camera, size: 16, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: hasText ? send : null,
                    child: Container(
                      width: 46,
                      height: 46,
                      decoration: const BoxDecoration(
                        color: _purple,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(hasText ? Icons.send : Icons.mic,
                          size: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  final List<Map<String, dynamic>> items = const [
    {
      'title': 'New Task Assigned to You!',
      'text':
      'You have new task for this sprint from Alicia, you can check your task "Create Onboarding Screen" by tap here',
      'icon': Icons.description,
      'tab': 2,
    },
    {
      'title': 'Expense has been approved!',
      'text': 'Your expense has been approved by jessica, view expense report here',
      'icon': Icons.description,
      'tab': 3,
    },
    {
      'title': 'You have invited in meeting!',
      'text': 'You have been invited to a meeting. Tap to find the meeting details',
      'icon': Icons.groups,
      'tab': 0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F3FA),
      appBar: _appBar(context, 'Messages'),
      body: ListView(
        children: items.map((item) {
          return InkWell(
            onTap: () {
              homeTabNotifier.value = item['tab'] as int;
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Color(0xFFF0F0F5))),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 42,
                    height: 46,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1EEFF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(item['icon'] as IconData,
                        size: 22, color: const Color(0xFFBDB0F5)),
                  ),
                   SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(item['title'] as String,
                                  style:  TextStyle(
                                      fontSize: 11, fontWeight: FontWeight.bold)),
                            ),
                             Text('09.10',
                                style: TextStyle(
                                    fontSize: 9, fontWeight: FontWeight.bold)),
                          ],
                        ),
                         SizedBox(height: 4),
                        Text(item['text'] as String,
                            style: const TextStyle(
                                fontSize: 9, color: Color(0xFF6B7280))),
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
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'main.dart'; // untuk akses currentUsername

class ChatDetailPage extends StatefulWidget {
  final String receiver;

  ChatDetailPage({required this.receiver});

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _messageController = TextEditingController();
  List<Map<String, dynamic>> chatMessages = [];

  @override
  void initState() {
    super.initState();
    loadMessages();
  }

  Future<void> loadMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('chat_history');
    if (jsonString != null) {
      final allChats = List<Map<String, dynamic>>.from(json.decode(jsonString));
      final filtered =
          allChats
              .where(
                (msg) =>
                    (msg['from'] == currentUsername &&
                        msg['to'] == widget.receiver) ||
                    (msg['from'] == widget.receiver &&
                        msg['to'] == currentUsername),
              )
              .toList();
      setState(() {
        chatMessages = filtered;
      });
    }
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('chat_history');
    List<Map<String, dynamic>> allChats =
        jsonString != null
            ? List<Map<String, dynamic>>.from(json.decode(jsonString))
            : [];

    final newMsg = {
      'from': currentUsername,
      'to': widget.receiver,
      'message': text,
      'timestamp': DateTime.now().toIso8601String(),
    };

    allChats.add(newMsg);
    await prefs.setString('chat_history', json.encode(allChats));

    _messageController.clear();
    loadMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2196F3), Color(0xFF0D47A1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
              child: Stack(
                children: [
                  // 🔙 Tombol kembali di kiri
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),

                  // 🏷 Nama penerima di tengah
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      " ${widget.receiver} ",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // 🖼 Logo di kanan
                  Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      'assets/images/logo2.png',
                      height: 120,
                      width: 120,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatMessages.length,
              itemBuilder: (_, index) {
                final msg = chatMessages[index];
                final isMe = msg['from'] == currentUsername;
                return Align(
                  alignment:
                      isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.deepPurple[100] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(msg['message']),
                  ),
                );
              },
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(hintText: "Ketik pesan..."),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => sendMessage(_messageController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

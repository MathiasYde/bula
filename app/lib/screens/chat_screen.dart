import 'package:aula/components/app_bar.dart';
import 'package:aula/data/chat.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final Chat chat;

  ChatScreen({
    this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BulaAppBar(showActions: false),
      body: ListView.builder(
        itemCount: chat.messages.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(child: Text("${chat.messages[0].content}"));
        },
      ),
    );
  }
}
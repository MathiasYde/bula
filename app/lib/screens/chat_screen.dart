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
    );
  }
}
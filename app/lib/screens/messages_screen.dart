import 'dart:convert';

import 'dart:ui';

import 'package:aula/components/quality_of_life.dart';
import 'package:aula/data/chat.dart';
import 'package:aula/data/message.dart';
import 'package:aula/data/person.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'chat_screen.dart';

class MessagesScreen extends StatefulWidget {
  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  Future<List<Message>> fetchChats() async {
    final response = await http
        .get("https://my-json-server.typicode.com/MathiasYde/bula/chats");

    if (response.statusCode == 200) {
      List<dynamic> parsed = json.decode(response.body);
      return parsed.map((e) => Message.fromJson(e)).toList();
    } else {
      throw Exception("Failed to fetch messages");
    }
  }

  Future<List<Message>> messages;

  @override
  void initState() {
    super.initState();
    messages = fetchChats();
  }

  @override
  Widget build(BuildContext context) {
    print("Building messages screen");
    return SafeArea(
      child: FutureBuilder<List<Message>>(
        future: messages,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return ChatCard(
                  chat: Chat(
                    name: "The gays",
                    messages: [
                      Message(
                        author: Person(firstname: "John", lastname: "Smith"),
                        content: "Are you ready for taco night?",
                      ),
                    ],
                  ),
                );
              },
            );
          }
          if (snapshot.hasError) {
            return ErrorCard(snapshot.error);
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ChatCard extends StatelessWidget {
  final Chat chat;

  const ChatCard({
    Key key,
    this.chat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(chat: chat),
            ),
          );
        },
        onLongPress: () {
          Scaffold.of(context).showBottomSheet(
            (context) => Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          offset: Offset(0, 3),
                          blurRadius: 2,
                          spreadRadius: 0.5,
                        )
                      ],
                      color: Colors.grey[300],
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Text(
                          "Choose an action for ${chat.messages[0].author.fullname}",
                          textScaleFactor: 1.5,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.error),
                    title: Text("Report"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.remove),
                    title: Text("Leave"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.volume_mute),
                    title: Text("Silence"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        },
        title: Text("${chat.messages[0].author.fullname}"),
        subtitle: Text("${chat.messages[0].content}"),
        leading: Tooltip(
          message: "${chat.messages[0].author.fullname}",
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: chat.messages[0].author.avatar,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


import 'dart:convert';

import 'package:aula/components/app_bar.dart';
import 'package:aula/components/navigation_bar.dart';
import 'package:aula/components/quick_actions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MessagesScreen extends StatefulWidget {
  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  Future<List<Message>> fetchMessages() async {
    final response = await http
        .get("https://my-json-server.typicode.com/MathiasYde/bula/messages");

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
    messages = fetchMessages();
  }

  @override
  Widget build(BuildContext context) {
    print("Building messages screen");
    return Scaffold(
        floatingActionButton: QuickActions(),
        bottomNavigationBar: NavigationBar(),
        appBar: BulaAppBar(),
        body: FutureBuilder<List<Message>>(
          future: messages,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return MessageCard(
                    index: index,
                    data: snapshot.data[index],
                  );
                },
              );
            }
            if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }
}

class MessageCard extends StatelessWidget {
  final int index;
  final Message data;

  const MessageCard({
    Key key,
    this.index,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(data.title),
        subtitle: Text(data.description),
        leading: Tooltip(
          message: "${data.author}",
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  "assets/fake-faces/fakeface-${''.padLeft(index.toString().length + 1, '0')}${(index + 1) % 20}.jpg",
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Message {
  String author;
  String title;
  String description;

  Message({this.author, this.title, this.description});

  Message.fromJson(Map<String, dynamic> data)
      : author = data["author"],
        title = data["title"],
        description = data["description"];

  Map<String, dynamic> toJson() => {
        "author": author,
        "title": title,
        "description": description,
      };
}

import 'dart:convert';

import 'package:aula/components/app_bar.dart';
import 'package:aula/components/quality_of_life.dart';
import 'package:aula/components/quick_actions.dart';
import 'package:aula/data/person.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MessagesScreen extends StatefulWidget {
  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  Future<List<Message>> fetchChats() async {
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
    messages = fetchChats();
  }

  @override
  Widget build(BuildContext context) {
    print("Building messages screen");
    return FutureBuilder<List<Message>>(
      future: messages,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return ChatCard(
                messages: [
                  Message(
                    author: Person(firstname: "Mathias", lastname: "Yde"),
                    content: "Bitch get the fuck away from me",
                  ),
                ],
              );
            },
          );
        }
        if (snapshot.hasError) {
          return ErrorCard(snapshot.error);
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class ChatCard extends StatelessWidget {
  final List<Message> messages;

  const ChatCard({
    Key key,
    this.messages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onLongPress: () {
          Scaffold.of(context).showBottomSheet(
            (context) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Choose an action for ${messages[0].author.fullname}", textScaleFactor: 1.5 ,style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.error),
                  title: Text("Report"),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.remove),
                  title: Text("Leave"),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.volume_mute),
                  title: Text("Silence"),
                  onTap: () {},
                ),
              ],
            ),
            shape: RoundedRectangleBorder(),
          );
        },
        title: Text("${messages[0].author.fullname}"),
        subtitle: Text("${messages[0].content}"),
        leading: Tooltip(
          message: "${messages[0].author.fullname}",
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: messages[0].author.avatar,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Chat {
  String name;
  List<Person> participants;
  List<Message> messages;

  Chat({this.name, this.participants, this.messages});

  Chat.fromJson(Map<String, dynamic> data)
      : name = data["name"],
        participants = data["participants"],
        messages = data["messages"];

  Map<String, dynamic> toJson() => {
        "name": name,
        "participants": participants,
        "messages": messages,
      };
}

class Message {
  Person author;
  String content;
  String date;

  Message({this.author, this.content, this.date});

  Message.fromJson(Map<String, dynamic> data)
      : author = Person.fromJson(data["author"]),
        content = data["content"],
        date = data["date"];

  Map<String, dynamic> toJson() => {
        "author": author,
        "content": content,
        "date": date,
      };
}

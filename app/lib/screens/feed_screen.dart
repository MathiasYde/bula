import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  Future<List<FeedPost>> fetchFeed() async {
    final response = await http
        .get("https://my-json-server.typicode.com/MathiasYde/bula/posts");

    if (response.statusCode == 200) {
      List<dynamic> parsed = json.decode(response.body);
      return parsed.map((e) => FeedPost.fromJson(e)).toList();
    } else {
      throw Exception("Failed to fetch feed");
    }
  }

  Future<List<FeedPost>> feedPosts;

  @override
  void initState() {
    super.initState();
    feedPosts = fetchFeed();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {},
              tooltip: "Overblik",
            ),
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () {},
              tooltip: "Kalender",
            ),
            IconButton(
              icon: Icon(Icons.message),
              onPressed: () {},
              tooltip: "Messages",
            ),
            IconButton(
              icon: Icon(Icons.nature),
              onPressed: () {},
              tooltip: "Something else",
            ),
          ],
        ),
      ),
      appBar: AppBar(),
      body: FutureBuilder<List<FeedPost>>(
        future: feedPosts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(snapshot.data[index].author),
                    subtitle: Text(snapshot.data[index].description),
                    leading: FlutterLogo(),
                  ),
                );
              },
            );
          }
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class FeedPost {
  String author;
  String title;
  String description;

  FeedPost({this.author, this.title, this.description});

  FeedPost.fromJson(Map<String, dynamic> data)
      : author = data["author"],
        title = data["title"],
        description = data["description"];

  Map<String, dynamic> toJson() => {
        "author": author,
        "title": title,
        "description": description,
      };
}

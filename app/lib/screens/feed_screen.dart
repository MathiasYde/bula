import 'dart:convert';

import 'package:aula/components/navigation_bar.dart';
import 'package:aula/components/quick_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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
    print("Building feed screen");
    var scaffold = Scaffold(
      floatingActionButton: QuickActions(),
      bottomNavigationBar: NavigationBar(),
      appBar: AppBar(
        leading: Image.asset("assets/logo/bula-logo-white.png")
      ),
      body: FutureBuilder<List<FeedPost>>(
        future: feedPosts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return FeedPostCard(
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
      ),
    );
    return scaffold;
  }
}

class FeedPostCard extends StatelessWidget {
  final int index;
  final FeedPost data;

  const FeedPostCard({
    Key key,
    this.data,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(data.author),
        subtitle: Text(data.description),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  "assets/fake-faces/fakeface-${''.padLeft(index.toString().length + 1, '0')}${(index + 1) % 20}.jpg",
                ),
              )),
        ),
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

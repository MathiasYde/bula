import 'dart:convert';

import 'package:aula/components/app_bar.dart';
import 'package:aula/data/person.dart';
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
      List<dynamic> parsed = jsonDecode(response.body);
      return parsed.map((e) => FeedPost.fromJson(e)).toList();
    } else {
      throw Exception("Failed to fetch feed");
    }
  }

  Future<void> onRefresh() async {
    setState(() {
      feedPosts = fetchFeed();
    });
  }

  Future<List<FeedPost>> feedPosts;

  @override
  void initState() {
    super.initState();
    feedPosts = fetchFeed();
  }

  Widget build(BuildContext context) {
    print("Building feed screen");
    return FutureBuilder<List<FeedPost>>(
      future: feedPosts,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return RefreshIndicator(
            onRefresh: onRefresh,
            child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return FeedPostCard(
                  index: index,
                  post: snapshot.data[index],
                );
              },
            ),
          );
        }
        if (snapshot.hasError) {
          return Center(child: Text("feed screen \n\n${snapshot.error}"));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class FeedPostCard extends StatelessWidget {
  final int index;
  final FeedPost post;

  const FeedPostCard({
    Key key,
    this.post,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Post(post: post)));
        },
        title: Text(post.title),
        subtitle: Text(post.description),
        leading: Tooltip(
          message: "${post.author.fullname}",
          child: Hero(
            tag: "${post.author.fullname}",
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: post.author.avatar,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Post extends StatelessWidget {
  final FeedPost post;
  const Post({
    Key key,
    this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BulaAppBar(
        showActions: false,
      ),
      body: ListTile(
        title: Text(post.title),
        subtitle: Text(post.description),
        leading: Tooltip(
          message: "${post.author.fullname}",
          child: Hero(
            tag: "${post.author.fullname}",
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: post.author.avatar,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FeedPost {
  Person author;
  String title;
  String description;

  FeedPost({this.author, this.title, this.description});

  FeedPost.fromJson(Map<String, dynamic> data)
      : author = Person.fromJson(data["author"]),
        title = data["title"],
        description = data["description"];

  Map<String, dynamic> toJson() => {
        "author": author,
        "title": title,
        "description": description,
      };
}

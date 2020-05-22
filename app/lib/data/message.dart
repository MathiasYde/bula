import 'person.dart';

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
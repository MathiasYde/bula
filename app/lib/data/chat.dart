import 'message.dart';
import 'person.dart';

class Chat {
  String name;
  List<Person> participants;
  List<Message> messages;

  Chat({this.name, this.participants, this.messages});

  Chat.fromJson(Map<String, dynamic> data)
      : name = data["name"],
        participants = data["participants"].map<Person>((e) => Person.fromJson(e)).toList(),
        messages = data["messages"].map<Message>((e) => Message.fromJson(e)).toList();

  Map<String, dynamic> toJson() => {
        "name": name,
        "participants": participants,
        "messages": messages,
      };
}
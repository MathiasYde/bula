import 'package:aula/components/app_bar.dart';
import 'package:aula/components/quick_actions.dart';
import 'package:aula/screens/feed_screen.dart';
import 'package:aula/screens/messages_screen.dart';
import 'package:flutter/material.dart';

class HubScreen extends StatefulWidget {
  @override
  _HubScreenState createState() => _HubScreenState();
}

class _HubScreenState extends State<HubScreen> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BulaAppBar(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        currentIndex: pageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Overblik"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text("Kalender"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title: Text("Beskeder"),
          ),
        ],
      ),
      floatingActionButton: QuickActions(),
      body: IndexedStack(
        index: pageIndex,
        children: [
          FeedScreen(),
          Center(child: Text("Not implemented yet :)")),
          MessagesScreen(),
        ],
      ),
    );
  }
}

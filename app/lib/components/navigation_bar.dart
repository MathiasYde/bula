import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget {
  Widget build(BuildContext context) {
    print("Building NavigationBar");
    return BottomAppBar(
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
    );
  }
}

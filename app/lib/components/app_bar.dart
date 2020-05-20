import 'package:flutter/material.dart';

class BulaAppBar extends StatelessWidget implements PreferredSizeWidget {
  //TODO: Try something else than this weird hack
  AppBar appBar = AppBar();

  @override
  Widget build(BuildContext context) {
    print("Building BulaAppBar");
    appBar = AppBar(
      leading: Image.asset("assets/logo/bula-logo-white.png"),
      actions: [
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            //TODO: Make it so it goes to the profile screen
          },
        ),
      ],
    );
    
    return appBar;
  }

  @override
  Size get preferredSize => appBar.preferredSize;
}

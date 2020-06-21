import 'package:flutter/material.dart';

class BulaAppBar extends StatelessWidget implements PreferredSizeWidget {
  //TODO: Try something else than this weird hack
  AppBar appBar = AppBar();
  bool showActions;

  BulaAppBar({
    Key key,
    this.showActions = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Building BulaAppBar");
    appBar = AppBar(
      leading: Image.asset("assets/logo/bula-logo-white.png"),
      actions: (showActions)
          ? [
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  //TODO: Make it so it goes to the profile screen

                  showAboutDialog(
                    applicationName: "",
                    applicationVersion: "v1.0a",
                      applicationIcon: SizedBox(
                        width: 50,
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(Colors.black, BlendMode.modulate),
                          child: Image.asset("assets/logo/bula-logo-white.png"),
                        ),
                      ),
                      context: context,
                      children: [Text("Use with caution")]);
                },
              ),
            ]
          : null,
    );
    return appBar;
  }

  @override
  Size get preferredSize => appBar.preferredSize;
}

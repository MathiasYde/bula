import 'package:flutter/Material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class QuickActions extends StatelessWidget {
  SpeedDial dial;
  ValueNotifier<bool> state = ValueNotifier(false);

  void pop() {
    state.value = false;
  }

  Widget build(BuildContext context) {
    print("Building QuickActions");
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      curve: Curves.bounceInOut,
      overlayOpacity: 0.3,
      overlayColor: Colors.black,
      children: [
        SpeedDialChild(
          child: Icon(Icons.home),
          label: "Opslag",
          onTap: () {
            print("MAKE OPSLAG");
          },
        ),
        SpeedDialChild(
          child: Icon(Icons.message),
          label: "Besked",
          onTap: () {
            print("MAKE BESKED");
          },
        ),
        SpeedDialChild(
          child: Icon(Icons.event),
          label: "Begivenhed",
          onTap: () {
            print("MAKE BEGIVENHED");
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class ErrorCard extends StatelessWidget {
  final Object error;

  const ErrorCard(
    this.error, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.error),
        Text(
          "An error occured",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text("$error"),
      ],
    );
  }
}

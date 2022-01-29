import 'package:flutter/material.dart';

class IsOnlineWidget extends StatefulWidget {
  const IsOnlineWidget({Key? key}) : super(key: key);

  @override
  _IsOnlineWidgetState createState() => _IsOnlineWidgetState();
}

class _IsOnlineWidgetState extends State<IsOnlineWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Icon(Icons.radio_button_on_outlined)],
    );
  }
}

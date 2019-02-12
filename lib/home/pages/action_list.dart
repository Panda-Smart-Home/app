import 'package:flutter/material.dart';

class ActionList extends StatefulWidget {
  ActionList({Key key}) : super(key: key);

  @override
  _ActionListState createState() => _ActionListState();
}

class _ActionListState extends State<ActionList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('Action')),
    );
  }
}

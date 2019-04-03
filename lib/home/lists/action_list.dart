import 'package:flutter/material.dart';
import 'package:app/helper.dart';
import 'package:app/models/action.dart';
import 'package:app/home/widgets/action_card.dart';

class ActionList extends StatefulWidget {
  ActionList({Key key}) : super(key: key);

  @override
  _ActionListState createState() => _ActionListState();
}

class _ActionListState extends State<ActionList> {
  List<ActionCard> actions = [];

  _ActionListState() {
    _getActions();
  }

  Future<Null> _getActions() async {
    var data = await getActions();
    List<ActionCard> cards = [];

    for (var action in data) {
      cards.add(ActionCard(action: Action.fromMap(action)));
    }

    setState(() {
      actions = cards;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _getActions,
      child: ListView(
          children: actions
      ),
    );
  }
}

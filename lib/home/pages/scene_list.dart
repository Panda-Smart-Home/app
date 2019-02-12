import 'package:flutter/material.dart';

class SceneList extends StatefulWidget {
  SceneList({Key key}) : super(key: key);

  @override
  _SceneListState createState() => _SceneListState();
}

class _SceneListState extends State<SceneList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('Scene')),
    );
  }
}

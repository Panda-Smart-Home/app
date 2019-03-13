import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:app/helper.dart';
import 'package:app/models/scene.dart';
import 'package:app/home/widgets/scene_card.dart';

class SceneList extends StatefulWidget {
  SceneList({Key key}) : super(key: key);

  @override
  _SceneListState createState() => _SceneListState();
}

class _SceneListState extends State<SceneList> {

  List<SceneCard> scenes = [];

  _SceneListState() {
    _getScenes();
  }

  Future<Null> _getScenes() async {
    Response response = await Dio().get(getApiUrl() + 'scenes');
    if (response.statusCode != 200) {
      return;
    }

    List<SceneCard> cards = [];
    for (var scene in response.data) {
      cards.add(SceneCard(scene: Scene.fromMap(scene)));
    }

    setState(() {
      scenes = cards;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _getScenes,
      child: ListView(
        children: scenes
      ),
    );
  }
}

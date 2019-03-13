import 'package:flutter/material.dart';
import 'package:app/models/scene.dart';

class SceneInfo extends StatelessWidget {

  SceneInfo({Key key, this.scene}) : super(key: key);

  final Scene scene;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(scene.name),
      ),
      body: RefreshIndicator(
        onRefresh: scene.refresh,
        child: ListView(
          children: <Widget>[
            Card(
              margin: EdgeInsets.only(left: 12, right: 12, top: 12),
              child: Padding(
                padding: EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('场景信息', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}

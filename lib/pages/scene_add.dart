import 'package:flutter/material.dart';
import 'package:app/pages/widgets/scene_rules.dart';


class SceneAdd extends StatelessWidget {

  SceneAdd({Key key}) : super(key: key);

  final nameField = TextEditingController(text: '');

  final rulesWidget = SceneRules(rules: []);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('新建场景'),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            margin: EdgeInsets.only(left: 12, right: 12, top: 12),
            child: Padding(
              padding: EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('场景名称：'),
                      Container(width: 240, child: TextField(maxLength: 20, controller: nameField))
                    ],
                  ),
                ],
              ),
            )
          ),
          Card(
              margin: EdgeInsets.only(left: 12, right: 12, top: 12),
              child: Padding(
                padding: EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SceneRules(rules: [])
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
}

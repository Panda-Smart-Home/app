import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:app/helper.dart';
import 'package:app/models/magic.dart';
import 'package:app/pages/widgets/scene_rules.dart';


class SceneAdd extends StatelessWidget {

  SceneAdd({Key key}) : super(key: key);

  final rulesWidget = SceneRules(rules: Magic([]));

  Future<bool> submit() async {
    List rules = [];
    for (var rule in rulesWidget.rules.content) {
      if (rule != null && rule['value'] != null) {
        rules.add(rule);
      }
    }
    String name = Global.get('new_scene_name');
    print(name);
    print(rules);
    if (name == null || name == '' || rules.isEmpty) {
      return false;
    }

    Response response = await Dio().post(getApiUrl() + 'scenes', data: {
      'name': name,
      'rules': rules
    });

    if (response.statusCode != 200) {
      return false;
    }
    print(response.data);
    return true;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('新建场景'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.check), onPressed: () {
            submit().then((ok) {
              if (ok) {
                Navigator.of(context).pop();
              } else {
                dialog(context, '错误', '新建失败');
              }
            });
          })
        ],
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
                      Container(width: 240, child: TextField(maxLength: 20, onChanged: (str) {Global.set('new_scene_name', str);}))
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
                    rulesWidget
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:app/helper.dart';
import 'package:app/home/home.dart';
import 'package:app/models/magic.dart';
import 'package:app/models/scene.dart';
import 'package:app/pages/widgets/scene_rules.dart';


class SceneInfo extends StatelessWidget {

  SceneInfo({Key key, this.scene}) : super(key: key) {
    Global.set('edit_scene_name', scene.name);
    List rules = [];
    for (var rule in scene.requirement) {
      rules.add(rule);
    }
    rulesWidget.setRules(rules);
  }

  final rulesWidget = SceneRules(rules: Magic([]));

  final Scene scene;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('场景信息')
      ),
      body: ListView(
        children: <Widget>[
          AbsorbPointer(
            child: Card(
              margin: EdgeInsets.only(left: 12, right: 12, top: 12),
              child: Padding(
                padding: EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 12, bottom: 12),
                          child: Text('场景名称：' + scene.name, style: TextStyle(fontSize: 20)),
                        )
                      ],
                    ),
                    rulesWidget
                  ],
                ),
              )
            ),
          ),
          Padding(
            padding: EdgeInsets.all(14),
            child: MaterialButton(
              child: Text('删除场景', style: TextStyle(color: Colors.white, fontSize: 16)),
              color: Colors.red,
              onPressed: () {
                askDialog(context, '删除提示', '您确定要删除该场景？', (){
                  scene.delete().then((res) {
                    if (res) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
                    } else {
                      dialog(context, '错误', '删除失败');
                    }
                  });
                });
              },
            ),
          )
        ],
      ),
    );
  }
}

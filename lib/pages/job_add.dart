import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:app/helper.dart';
import 'package:app/models/job.dart';
import 'package:app/home/widgets/job_card.dart';

class JobAdd extends StatefulWidget {
  JobAdd({Key key}) : super(key: key);

  @override
  _JobAddState createState() => _JobAddState();
}

class _JobAddState extends State<JobAdd> {
  TextEditingController nameController = TextEditingController(text: '');
  TextStyle style =  TextStyle(fontSize: 18);
  List<DropdownMenuItem<int>> actionItems = [];
  List<DropdownMenuItem<int>> sceneItems = [];
  int actionId;
  int sceneId;

  _JobAddState() {
    getActions().then((actions) {
      for (var action in actions) {
        actionItems.add(DropdownMenuItem(value: action['id'], child: Text(action['name'])));
      }
      setState(() {});
    });
    getScenes().then((scenes) {
      for (var scene in scenes) {
        sceneItems.add(DropdownMenuItem(value: scene['id'], child: Text(scene['name'])));
      }
      setState(() {});
    });
  }

  Future<bool> submit() async {
    if (actionId == null || sceneId == null || nameController.text.length == 0) {
      return false;
    }

    Response response = await Dio().post(getApiUrl() + 'jobs', data: {
      'name': nameController.text,
      'action_id': actionId,
      'scene_id': sceneId
    });

    if (response.statusCode != 200) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('新建任务'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.check), onPressed: () {
            submit().then((res) {
              if (res == false) {
                dialog(context, '新建失败', '新建任务失败');
              } else {
                Navigator.of(context).pop();
              }
            });
          })
        ],
      ),
      body: ListView(
        children:[
          Card(
            margin: EdgeInsets.only(left: 12, right: 12, top: 12),
            child: Padding(
              padding: EdgeInsets.all(14),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('任务名称：', style: style),
                      Container(
                          width: 240,
                          child: TextField(maxLength: 20, controller: nameController)
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('关联场景：', style: style),
                      DropdownButton(
                        value: sceneId,
                        hint: Text('场景'),
                        items: sceneItems,
                        onChanged: (id) {sceneId = id;setState(() {});},
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('关联行为：', style: style),
                      DropdownButton(
                        value: actionId,
                        hint: Text('行为'),
                        items: actionItems,
                        onChanged: (id) {this.actionId = id;setState(() {});},
                      )
                    ],
                  )
                ],
              ),
            )
          ),
        ]
      ),
    );
  }
}

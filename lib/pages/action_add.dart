import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:app/helper.dart';
import 'package:app/models/magic.dart';
import 'package:app/pages/widgets/action_todos.dart';

class ActionAdd extends StatelessWidget {

  ActionAdd({Key key}) : super(key: key);

  final todosWidget = ActionTodos(todos: Magic([]));

  Future<bool> submit() async {
    List todos = [];
    for (var todo in todosWidget.todos.content) {
      if (todo != null && todo['value'] != null) {
        todos.add(todo);
      }
    }
    String name = Global.get('new_action_name');
    print(name);
    print(todos);
    if (name == null || name == '' || todos.isEmpty) {
      return false;
    }

    Response response = await Dio().post(getApiUrl() + 'actions', data: {
      'name': name,
      'todo': todos
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
        title: Text('新建行为'),
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
                        Text('行为名称：'),
                        Container(width: 240, child: TextField(maxLength: 20, onChanged: (str) {Global.set('new_action_name', str);}))
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
                    todosWidget
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
}

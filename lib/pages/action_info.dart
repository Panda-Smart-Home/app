import 'package:flutter/material.dart';
import 'package:app/helper.dart';
import 'package:app/home/home.dart';
import 'package:app/models/magic.dart';
import 'package:app/models/action.dart';
import 'package:app/pages/widgets/action_todos.dart';


class ActionInfo extends StatelessWidget {

  ActionInfo({Key key, this.action}) : super(key: key) {
    List todos = [];
    for (var todo in action.todo) {
      todos.add(todo);
    }
    todosWidget.setTodos(todos);
  }

  final todosWidget = ActionTodos(todos: Magic([]));

  final Action action;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('行为信息')
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
                            child: Text('行为名称：' + action.name, style: TextStyle(fontSize: 20)),
                          )
                        ],
                      ),
                      todosWidget
                    ],
                  ),
                )
            ),
          ),
          Padding(
            padding: EdgeInsets.all(14),
            child: MaterialButton(
              child: Text('删除行为', style: TextStyle(color: Colors.white, fontSize: 16)),
              color: Colors.red,
              onPressed: () {
                askDialog(context, '删除提示', '您确定要删除该行为？', (){
                  action.delete().then((res) {
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

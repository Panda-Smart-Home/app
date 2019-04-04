import 'package:flutter/material.dart';
import 'package:app/models/magic.dart';
import 'package:app/pages/widgets/action_todo.dart';

class ActionTodos extends StatefulWidget {
  ActionTodos({Key key, this.todos}) : super(key: key);

  final Magic todos;

  void setTodos(newTodos) {
    todos.content = newTodos;
  }

  @override
  _ActionTodosState createState() => _ActionTodosState();
}

class _ActionTodosState extends State<ActionTodos> {

  _ActionTodosState() : super();

  List todos = [];

  List<Widget> todoWidgets = [];

  @override
  void initState() {
    todos = widget.todos.content;
    _buildTodos();
    super.initState();
  }

  void _addTodo() {
    todos.add(null);
    todoWidgets.add(_buildTodo(null));
    setState(() {});
  }

  Widget _buildTodo(todo) {
    var i = todos.indexOf(todo);
    return ActionTodo(
      todo: todo,
      onChange: (newTodo){todos[i] = newTodo;widget.todos.content = todos;print(todos);},
    );
  }

  void _buildTodos() {
    todoWidgets = [];
    todoWidgets.add(Row(
      children: <Widget>[
        Text('关联操作：'),
        FlatButton(child: Icon(Icons.add), onPressed: (){_addTodo();}),
      ],
    ));
    for(var todo in todos) {
      todoWidgets.add(_buildTodo(todo));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: todoWidgets
    );
  }
}

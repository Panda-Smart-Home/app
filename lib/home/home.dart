import 'package:flutter/material.dart';
import 'package:app/helper.dart';
import 'package:app/home/lists/job_list.dart';
import 'package:app/home/lists/action_list.dart';
import 'package:app/home/lists/scene_list.dart';
import 'package:app/home/lists/device_list.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _pages = [
    DeviceList(),
    JobList(),
    ActionList(),
    SceneList(),
  ];

  final _titles = [
    Text('设备列表'),
    Text('任务列表'),
    Text('行为列表'),
    Text('场景列表'),
  ];

  final _bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.devices), title: Text('设备')),
    BottomNavigationBarItem(icon: Icon(Icons.list), title: Text('任务')),
    BottomNavigationBarItem(icon: Icon(Icons.videogame_asset), title: Text('行为')),
    BottomNavigationBarItem(icon: Icon(Icons.view_compact), title: Text('场景')),
  ];

  var _currentIndex = 0;

  FloatingActionButton _floatingActionButton;

  var _hostInputController = TextEditingController();

  Future<void> setHostDialog(context) async {
    _hostInputController.text = Global.get('host');
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('设置智能家居中心IP'),
          content: TextField(controller: _hostInputController),
          actions: <Widget>[
            FlatButton(
              child: Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('确认'),
              onPressed: () {
                Global.set('host', _hostInputController.text);
                Global.get('prefs').setString('host', _hostInputController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _titles[_currentIndex],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              setHostDialog(context);
            },
          )
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomItems,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
            switch (index) {
              case 0: _floatingActionButton = null;return;
              case 1: _floatingActionButton = getAddJobButton(context);return;
              case 2: _floatingActionButton = getAddActionButton(context);return;
              case 3: _floatingActionButton = getAddSceneButton(context);return;
            }
          });
        },
      ),
      floatingActionButton: _floatingActionButton
    );
  }
}

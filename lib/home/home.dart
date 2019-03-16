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
    JobList(),
    ActionList(),
    SceneList(),
    DeviceList(),
  ];

  final _titles = [
    Text('任务列表'),
    Text('行为列表'),
    Text('场景列表'),
    Text('设备列表'),
  ];

  final _bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.list), title: Text('任务')),
    BottomNavigationBarItem(icon: Icon(Icons.videogame_asset), title: Text('行为')),
    BottomNavigationBarItem(icon: Icon(Icons.view_compact), title: Text('场景')),
    BottomNavigationBarItem(icon: Icon(Icons.devices), title: Text('设备')),
  ];

  var _currentIndex = 0;

  FloatingActionButton _floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _titles[_currentIndex],
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
              case 1: _floatingActionButton = null;return;
              case 2: _floatingActionButton = getAddSceneButton(context);return;
              case 3: _floatingActionButton = null;return;
            }
          });
        },
      ),
      floatingActionButton: _floatingActionButton
    );
  }
}

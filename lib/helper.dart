import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'models/device.dart';
import 'pages/job_add.dart';
import 'pages/scene_add.dart';
import 'pages/action_add.dart';

String deviceTypeToString(DeviceTypes type) {
  switch (type) {
    case DeviceTypes.power:
      return '智能插座';
    case DeviceTypes.sensirion:
      return '温湿度传感器';
    case DeviceTypes.server:
      return '智能家居中心';
  }
  return '未知';
}

DeviceTypes stringToDeviceType(String type) {
  switch (type) {
    case 'power':
      return DeviceTypes.power;
    case 'sensirion':
      return DeviceTypes.sensirion;
    case 'server':
      return DeviceTypes.server;
  }
  return DeviceTypes.power;
}

String getApiUrl() {
  return 'http://' + Global.get('host') + '/';
}

Future<dynamic> getDevices() async {
  Response response = await Dio().get(getApiUrl() + 'devices');
  if (response.statusCode != 200) {
    return [];
  }
  Global.set('devices', response.data);
  return response.data;
}

Future<dynamic> getScenes() async {
  Response response = await Dio().get(getApiUrl() + 'scenes');
  if (response.statusCode != 200) {
    return [];
  }
  Global.set('scenes', response.data);
  return response.data;
}

Future<dynamic> getActions() async {
  Response response = await Dio().get(getApiUrl() + 'actions');
  if (response.statusCode != 200) {
    return [];
  }
  Global.set('actions', response.data);
  return response.data;
}

Future<dynamic> getJobs() async {
  Response response = await Dio().get(getApiUrl() + 'jobs');
  if (response.statusCode != 200) {
    return [];
  }
  Global.set('jobs', response.data);
  return response.data;
}

List<DropdownMenuItem<String>> getDevicePropertiesMenuItemList(device)
{
  List<DropdownMenuItem<String>> list;

  switch (device['type']) {
    case 'power':
      list = [
        DropdownMenuItem(value: 'power', child: Text('开关'))
      ];
      break;
    case 'sensirion':
      list = [
        DropdownMenuItem(value: 'temperature', child: Text('温度')),
        DropdownMenuItem(value: 'humidity', child: Text('湿度')),
      ];
      break;
    case 'server':
      list = [
        DropdownMenuItem(value: 'time', child: Text('时间')),
      ];
      break;
  }

  return list;
}

PropertyTypes getPropertyTypeByProperty(property)
{
  if (property == null) {
    return PropertyTypes.unknown;
  }

  switch (property) {
    case 'power': return PropertyTypes.bool;
    case 'temperature': return PropertyTypes.num;
    case 'humidity': return PropertyTypes.num;
    case 'time': return PropertyTypes.time;
  }

  return PropertyTypes.unknown;
}

List<DropdownMenuItem> getOperatorMenuItemListByType(PropertyTypes type)
{
  List<DropdownMenuItem> list;

  switch (type) {
    case PropertyTypes.bool:
      list = [
        DropdownMenuItem(value: true, child: Text('等于')),
        DropdownMenuItem(value: false, child: Text('不等于'))
      ];
      break;
    case PropertyTypes.num:
      list = [
        DropdownMenuItem(value: -2, child: Text('<')),
        DropdownMenuItem(value: -1, child: Text('<=')),
        DropdownMenuItem(value: 0, child: Text('=')),
        DropdownMenuItem(value: 1, child: Text('>=')),
        DropdownMenuItem(value: 2, child: Text('>')),
      ];
      break;
    case PropertyTypes.time:
      list = [
        DropdownMenuItem(value: 1, child: Text('每天')),
        DropdownMenuItem(value: 0, child: Text('工作日')),
        DropdownMenuItem(value: -1, child: Text('每周一')),
        DropdownMenuItem(value: -2, child: Text('每周二')),
        DropdownMenuItem(value: -3, child: Text('每周三')),
        DropdownMenuItem(value: -4, child: Text('每周四')),
        DropdownMenuItem(value: -5, child: Text('每周五')),
        DropdownMenuItem(value: -6, child: Text('每周六')),
        DropdownMenuItem(value: -7, child: Text('每周日')),
      ];
      break;
    case PropertyTypes.unknown: break;
  }

  return list;
}

FloatingActionButton getAddJobButton(context) {
  return FloatingActionButton(
    onPressed: (){
      // TODO
      Navigator.push(context, MaterialPageRoute(builder: (context) => JobAdd()));
    },
    child: Icon(Icons.add),
  );
}

FloatingActionButton getAddActionButton(context) {
  return FloatingActionButton(
    onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => ActionAdd()));
    },
    child: Icon(Icons.add),
  );
}

FloatingActionButton getAddSceneButton(context) {
  return FloatingActionButton(
    onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => SceneAdd()));
    },
    child: Icon(Icons.add),
  );
}

void selectDate(BuildContext context, fn) {
  var selectedTime = showTimePicker(
    initialTime: TimeOfDay.now(),
    context: context,
  );
  selectedTime.then(fn);
}

class Global
{
  static final Map<String, dynamic> _variables = {};

  static dynamic get(String key) {
    if (_variables.containsKey(key)) {
      return _variables[key];
    } else {
      return null;
    }
  }

  static void set(String key, value) {
    _variables[key] = value;
  }
}

Future<void> dialog(context, title, text) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(text),
        actions: <Widget>[
          FlatButton(
            child: Text('确认'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> askDialog(context, title, text, [fn]) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(text),
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
              Navigator.of(context).pop();
              if (fn != null) {
                fn();
              }
            },
          ),
        ],
      );
    },
  );
}
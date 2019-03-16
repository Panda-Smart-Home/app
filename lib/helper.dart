import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'models/device.dart';
import 'pages/scene_add.dart';

String deviceTypeToString(DeviceTypes type) {
  switch (type) {
    case DeviceTypes.power:
      return '智能插座';
    case DeviceTypes.sensirion:
      return '温湿度传感器';
  }
  return '未知';
}

DeviceTypes stringToDeviceType(String type) {
  switch (type) {
    case 'power':
      return DeviceTypes.power;
    case 'sensirion':
      return DeviceTypes.sensirion;
  }
  return DeviceTypes.power;
}

String getApiUrl() {
  return 'http://192.168.100.103:8000/';
}

Future<dynamic> getDevices() async {
  Response response = await Dio().get(getApiUrl() + 'devices');
  if (response.statusCode != 200) {
    return [];
  }

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
        DropdownMenuItem(value: -2, child: Text('<=')),
        DropdownMenuItem(value: -1, child: Text('<')),
        DropdownMenuItem(value: 0, child: Text('=')),
        DropdownMenuItem(value: 1, child: Text('>')),
        DropdownMenuItem(value: 2, child: Text('>=')),
      ];
      break;
    case PropertyTypes.unknown: break;
  }

  return list;
}

FloatingActionButton getAddSceneButton(context) {
  return FloatingActionButton(
    onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => SceneAdd()));
    },
    child: Icon(Icons.add),
  );
}

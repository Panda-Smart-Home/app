import 'package:flutter/material.dart';
import 'models/device.dart';

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
  return 'http://192.168.100.104:8000/';
}

FloatingActionButton getAddSceneButton() {
  return FloatingActionButton(
    onPressed: (){},
    child: Icon(Icons.add),
  );
}

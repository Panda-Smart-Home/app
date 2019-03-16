import 'package:dio/dio.dart';
import 'package:app/helper.dart';

enum DeviceTypes {
  power,
  sensirion,
}

enum PropertyTypes {
  num,
  bool,
  unknown,
}

class Device
{
  Device({this.id, this.name, this.type});

  int id;
  String name;
  DeviceTypes type;
  dynamic status;

  Future<bool> refresh() async {
    Response response = await Dio().get(
        getApiUrl() + 'devices/' + this.id.toString()
    );
    if (response.statusCode != 200) {
      return false;
    }
    this.id = response.data['id'];
    this.name = response.data['name'];
    this.type = stringToDeviceType(response.data['type']);
    this.status = response.data['status'];
    return true;
  }


  Future<bool> updateName(String name) async {
    Response response = await Dio().patch(
        getApiUrl() + 'devices/' + this.id.toString(),
        data: {'name': name}
    );
    if (response.statusCode != 200) {
      return false;
    }
    this.name = name;
    return true;
  }

  Future<bool> updateStatus(Map<String, dynamic> status) async {
    Response response = await Dio().patch(
      getApiUrl() + 'devices/' + this.id.toString(),
      data: {'status': status}
    );
    if (response.statusCode != 200) {
      return false;
    }
    this.status = status;
    return true;
  }

  Device.fromMap(map) {
    id = map['id'];
    name = map['name'];
    status = map['status'];
    // 设置设备类型
    switch (map['type']) {
      case 'power':
        type = DeviceTypes.power;
        break;
      case 'sensirion':
        type = DeviceTypes.sensirion;
        break;
    }
  }
}
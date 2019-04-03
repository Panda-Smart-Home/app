import 'package:dio/dio.dart';
import 'package:app/helper.dart';

class Action
{
  Action({this.id, this.name, this.todo});

  int id;
  String name;
  dynamic todo;
  dynamic devices;

  Future<bool> refresh() async {
    Response response = await Dio().get(
        getApiUrl() + 'actions/' + this.id.toString()
    );
    if (response.statusCode != 200) {
      return false;
    }
    this.id = response.data['id'];
    this.name = response.data['name'];
    this.todo = response.data['todo'];
    this.devices = response.data['devices'];
    return true;
  }

  Future<bool> delete() async {
    Response response = await Dio().delete(
        getApiUrl() + 'actions/' + this.id.toString()
    );
    if (response.statusCode != 204) {
      return false;
    }
    return true;
  }

  Action.fromMap(map) {
    id = map['id'];
    name = map['name'];
    todo = map['todo'];
    devices = map['devices'];
  }
}
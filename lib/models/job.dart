import 'package:dio/dio.dart';
import 'package:app/helper.dart';
import 'package:app/models/action.dart';
import 'package:app/models/scene.dart';

class Job {
  Job({this.id, this.name, this.actionId, this.sceneId});

  int id;
  String name;
  int actionId;
  int sceneId;

  Action action;
  Scene scene;

  Future<bool> refresh() async {
    getActions();
    getScenes();
    Response response =
        await Dio().get(getApiUrl() + 'jobs/' + this.id.toString());
    if (response.statusCode != 200) {
      return false;
    }
    this.id = response.data['id'];
    this.name = response.data['name'];
    this.actionId = response.data['actionId'];
    this.sceneId = response.data['sceneId'];
    this.action = Action.fromMap(response.data['action']);
    this.scene = Scene.fromMap(response.data['scene']);
    return true;
  }

  Future<bool> delete() async {
    Response response =
        await Dio().delete(getApiUrl() + 'jobs/' + this.id.toString());
    if (response.statusCode != 204) {
      return false;
    }
    return true;
  }

  Job.fromMap(map) {
    id = map['id'];
    name = map['name'];
    actionId = map['actionId'];
    sceneId = map['sceneId'];
    action = Action.fromMap(map['action']);
    scene = Scene.fromMap(map['scene']);
  }
}

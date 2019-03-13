import 'package:dio/dio.dart';
import 'package:app/helper.dart';

class Scene
{
  Scene({this.id, this.name, this.requirement});

  int id;
  String name;
  dynamic requirement;

  Future<bool> refresh() async {
    Response response = await Dio().get(
        getApiUrl() + 'scene/' + this.id.toString()
    );
    if (response.statusCode != 200) {
      return false;
    }
    this.id = response.data['id'];
    this.name = response.data['name'];
    return true;
  }

  Scene.fromMap(map) {
    id = map['id'];
    name = map['name'];
    requirement = map['requirement'];
  }
}
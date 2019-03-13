import 'package:flutter/material.dart';
import 'package:app/models/scene.dart';
import 'package:app/pages/scene_info.dart';

class SceneCard extends StatefulWidget {
  SceneCard({Key key, this.scene}) : super(key: key);

  final Scene scene;

  @override
  _SceneCardState createState() => _SceneCardState();
}

class _SceneCardState extends State<SceneCard> {

  Icon icon = Icon(Icons.widgets);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12, right: 12, top: 12),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SceneInfo(scene: widget.scene)));
        },
        child: Card(
          child: Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 6),
                    child: icon,
                  ),
                  Text(
                    widget.scene.name,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              )
          ),
        ),
      ),
    );
  }
}

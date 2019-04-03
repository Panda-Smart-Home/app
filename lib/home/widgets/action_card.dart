import 'package:flutter/material.dart';
import 'package:app/models/action.dart';

class ActionCard extends StatefulWidget {
  ActionCard({Key key, this.action}) : super(key: key);

  final Action action;

  @override
  _ActionCardState createState() => _ActionCardState();
}

class _ActionCardState extends State<ActionCard> {

  Icon icon = Icon(Icons.build);

  @override
  void initState() {
    super.initState();
  }

  Widget _getRelatedDevices() {

    String text = '关联设备：';

    int i = 0;
    for (var name in widget.action.devices) {
      text = text + ' ' + name;
      i++;
      if (i >= 3) {
        text = text + '...';
        break;
      }
    }

    return Expanded(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
          ),
        )
    );

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12, right: 12, top: 12),
      child: InkWell(
        onTap: () {
          // TODO
//          Navigator.push(context, MaterialPageRoute(builder: (context) => SceneInfo(scene: widget.action)));
        },
        child: Card(
          child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 6),
                        child: icon,
                      ),
                      Text(
                        widget.action.name,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  Row(
                      children: <Widget>[
                        _getRelatedDevices()
                      ]
                  )
                ],
              )
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../models/device.dart';
import 'power_status.dart';

class PowerAction extends StatefulWidget {
  PowerAction({Key key, this.device}) : super(key: key);

  final Device device;

  @override
  _PowerActionState createState() => _PowerActionState();
}

class _PowerActionState extends State<PowerAction> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 12, right: 12, top: 12),
      child: Padding(
        padding: EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('设备控制', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Row(
              children: <Widget>[
                Text('开关: ', style: TextStyle(fontSize: 18)),
                PowerStatus(device: widget.device, isControl: true)
              ],
            )
          ],
        ),
      )
    );
  }
}
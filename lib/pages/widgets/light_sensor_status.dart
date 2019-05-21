import 'package:flutter/material.dart';
import '../../models/device.dart';

class LightSensorStatus extends StatefulWidget {
  LightSensorStatus({Key key, this.device}) : super(key: key);

  final Device device;

  @override
  _LightSensorStatusState createState() => _LightSensorStatusState();
}

class _LightSensorStatusState extends State<LightSensorStatus> {

  String isLight;

  @override
  void initState() {
    if (widget.device.status['isLight'] == true) {
      isLight = '有光';
    } else {
      isLight = '无光';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(isLight, style: TextStyle(fontSize: 18)),
      ],
    );
  }
}

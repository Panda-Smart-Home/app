import 'package:flutter/material.dart';
import '../../models/device.dart';

class SensirionStatus extends StatefulWidget {
  SensirionStatus({Key key, this.device}) : super(key: key);

  final Device device;

  @override
  _SensirionStatusState createState() => _SensirionStatusState();
}

class _SensirionStatusState extends State<SensirionStatus> {

  num temperature;
  num humidity;

  @override
  void initState() {
    temperature = widget.device.status['temperature'];
    humidity = widget.device.status['humidity'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('温度： $temperature°', style: TextStyle(fontSize: 16)),
        Text('湿度： $humidity%', style: TextStyle(fontSize: 16)),
      ],
    );
  }
}

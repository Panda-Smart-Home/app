import 'package:flutter/material.dart';
import '../../models/device.dart';

class ServerStatus extends StatefulWidget {
  ServerStatus({Key key, this.device}) : super(key: key);

  final Device device;

  @override
  _ServerStatusState createState() => _ServerStatusState();
}

class _ServerStatusState extends State<ServerStatus> {

  String time;

  @override
  void initState() {
    time = widget.device.status['time'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Text('$time', style: TextStyle(fontSize: 18));
  }
}

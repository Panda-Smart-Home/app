import 'package:flutter/material.dart';
import 'package:app/models/device.dart';
import 'package:app/pages/device_info.dart';

class DeviceCard extends StatefulWidget {
  DeviceCard({Key key, this.device}) : super(key: key);

  final Device device;

  @override
  _DeviceCardState createState() => _DeviceCardState();
}

class _DeviceCardState extends State<DeviceCard> {

  Icon icon = Icon(Icons.devices);

  @override
  void initState() {
    switch (widget.device.type) {
      case DeviceTypes.power: icon = Icon(Icons.power_settings_new);break;
      case DeviceTypes.sensirion: icon = Icon(Icons.theaters);break;
      case DeviceTypes.server: icon = Icon(Icons.computer);break;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12, right: 12, top: 12),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DeviceInfo(device: widget.device)));
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
                  widget.device.name,
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

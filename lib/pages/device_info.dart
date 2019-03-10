import 'package:flutter/material.dart';
import 'package:app/helper.dart';
import 'package:app/models/device.dart';
import 'package:app/pages/widgets/power_status.dart';
import 'package:app/pages/widgets/power_action.dart';

class DeviceInfo extends StatelessWidget {

  DeviceInfo({Key key, this.device}) : super(key: key);

  final Device device;

  Widget _getStatus() {
    switch (device.type) {
      case DeviceTypes.power:
        return PowerStatus(device: device, isControl: false);
      case DeviceTypes.sensirion:
        // TODO
        return Text('TODO');
    }
    return Text('no match');
  }

  Widget _getAction() {
    switch (device.type) {
      case DeviceTypes.power:
        return PowerAction(device: device,);
      case DeviceTypes.sensirion:
        // TODO
        return Text('TODO');
    }
    return Text('no match');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(device.name),
      ),
      body: RefreshIndicator(
        onRefresh: device.refresh,
        child: ListView(
          children: <Widget>[
            Card(
              margin: EdgeInsets.only(left: 12, right: 12, top: 12),
              child: Padding(
                padding: EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('设备信息', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    Text('设备ID: ' + device.id.toString(), style: TextStyle(fontSize: 18)),
                    InkWell(
                      onTap: () {
                        showDialog<Null>(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            TextEditingController _name = TextEditingController(text: device.name);
                            return AlertDialog(
                              title: Text('修改设备名称：'),
                              content: TextField(maxLength: 20, controller: _name),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('确定'),
                                  onPressed: () {
                                    device.updateName(_name.text);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text('设备名称: ' + device.name, style: TextStyle(fontSize: 18)),
                    ),
                    Text('设备类型: ' + deviceTypeToString(device.type),  style: TextStyle(fontSize: 18)),
                    Row(
                      children: <Widget>[
                        Text('设备状态: ', style: TextStyle(fontSize: 18)),
                        _getStatus()
                      ],
                    )
                  ],
                ),
              )
            ),
            _getAction()
          ],
        ),
      ),
    );
  }
}

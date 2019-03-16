import 'package:flutter/material.dart';
import 'package:app/helper.dart';
import 'package:app/models/device.dart';
import 'package:app/home/widgets/device_card.dart';

class DeviceList extends StatefulWidget {
  DeviceList({Key key}) : super(key: key);

  @override
  _DeviceListState createState() => _DeviceListState();
}

class _DeviceListState extends State<DeviceList> {

  List<DeviceCard> devices = [];

  _DeviceListState() {
    _getDevices();
  }

  Future<Null> _getDevices() async {
    var data = await getDevices();
    List<DeviceCard> cards = [];

    for (var device in data) {
      cards.add(DeviceCard(device: Device.fromMap(device)));
    }

    setState(() {
      devices = cards;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _getDevices,
      child: ListView(
        children: devices
      ),
    );
  }
}

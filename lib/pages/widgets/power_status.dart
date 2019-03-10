import 'package:flutter/material.dart';
import '../../models/device.dart';

class PowerStatus extends StatefulWidget {
  PowerStatus({Key key, this.device, this.isControl}) : super(key: key);

  final Device device;

  final bool isControl;

  @override
  _PowerStatusState createState() => _PowerStatusState();
}

class _PowerStatusState extends State<PowerStatus> {

  @override
  void initState() {
    _val = widget.device.status['power'];
    super.initState();
  }

  bool _val;

  void _updateSwitch(bool val) {
    widget.device.updateStatus({'power': val}).then((res) {
      if (res) {
        setState(() {
          _val = val;
        });
      }
    });
  }

  Widget _getStatusControl() {
    return Switch(
      value: _val,
      onChanged: _updateSwitch,
    );
  }

  Widget _getStatusText() {
    String power = '关';
    if (widget.device.status['power']) {
      power = '开';
    }
    return Text(power, style: TextStyle(fontSize: 18));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isControl) {
      return _getStatusControl();
    }
    return _getStatusText();
  }
}

import 'package:flutter/material.dart';
import 'package:app/helper.dart';
import 'package:app/models/device.dart';

class ActionTodo extends StatefulWidget {
  ActionTodo({Key key, this.todo, this.onChange}) : super(key: key);

  final todo;

  final onChange;

  @override
  _ActionTodoState createState() => _ActionTodoState();
}

class _ActionTodoState extends State<ActionTodo> {

  List<DropdownMenuItem<int>> deviceItems = [];

  List<DropdownMenuItem<String>> propertyItems = [];

  int selectDeviceId;

  String selectDeviceProperty;

  var value;

  var currentDevice;

  bool close = false;

  var devices = Global.get('devices');

  @override
  void initState() {
    if (devices == null) {
      close = true;
      getDevices().then((val) {
        devices = val;
        close = false;
        for (var device in devices) {
          if (device['type'] != 'power' && device['type'] != 'server') {
            continue;
          }
          if (widget.todo != null && widget.todo['id'] == device['id']) {
            currentDevice = device;
          }
          deviceItems.add(DropdownMenuItem(child: Text(device['name']), value: device['id']));
        }
        setState(() {});
      });
    } else {
      for (var device in devices) {
        if (device['type'] != 'power' && device['type'] != 'server') {
          continue;
        }
        if (widget.todo != null && widget.todo['id'] == device['id']) {
          currentDevice = device;
        }
        deviceItems.add(DropdownMenuItem(child: Text(device['name']), value: device['id']));
      }
    }

    super.initState();
  }


  Widget _getValueWidget(PropertyTypes type) {
    switch (type) {
      case PropertyTypes.bool:
        return DropdownButton(
            value: value,
            items: [
              DropdownMenuItem(value: true, child: Text('开')),
              DropdownMenuItem(value: false, child: Text('关')),
            ],
            hint: Text('值'),
            onChanged: (currentValue) {
              value = currentValue;
              widget.onChange({
                'id': selectDeviceId,
                'property': selectDeviceProperty,
                'value': value
              });
              setState(() {});
            }
        );
      case PropertyTypes.num: return Text('');
      case PropertyTypes.time: return Text('');
      case PropertyTypes.unknown:
        return DropdownButton(
            value: value,
            items: [
              DropdownMenuItem(value: true, child: Text('发送')),
            ],
            hint: Text('值'),
            onChanged: (currentValue) {
              value = currentValue;
              widget.onChange({
                'id': selectDeviceId,
                'property': selectDeviceProperty,
                'value': value
              });
              setState(() {});
            }
        );
    }
    return Text('');
  }

  void _deviceChange(id) {
    for (var device in devices) {
      if (device['id'] == id) {
        selectDeviceId = id;
        currentDevice = device;
        propertyItems = getDeviceActionPropertiesMenuItemList(device);
        selectDeviceProperty = null;
        value = null;
        setState(() {});
        break;
      }
    }
    widget.onChange({
      'id': selectDeviceId,
      'property': selectDeviceProperty,
      'value': value
    });
  }

  void _propertyChange(property) {
    selectDeviceProperty = property;
    value = null;
    setState(() {});
    widget.onChange({
      'id': selectDeviceId,
      'property': selectDeviceProperty,
      'value': value
    });
  }

  @override
  Widget build(BuildContext context) {
    if (close) {
      return Text('');
    }

    if (widget.todo != null) {
      selectDeviceId = widget.todo['id'];
      selectDeviceProperty = widget.todo['property'];
      value = widget.todo['value'];
      return Row(
        children: <Widget>[
          Text('令'),
          DropdownButton(
            value: selectDeviceId,
            items: deviceItems,
            hint: Text('设备'),
            onChanged: _deviceChange
          ),
          Text('的'),
          DropdownButton(
            value: selectDeviceProperty,
            items: getDeviceActionPropertiesMenuItemList(currentDevice),
            hint: Text('属性'),
            onChanged: _propertyChange
          ),
          Text('为'),
          _getValueWidget(getPropertyTypeByProperty(selectDeviceProperty)),
          IconButton(icon: Icon(Icons.close), onPressed: (){widget.onChange(null); close = true; setState(() {});}),
        ],
      );
    }

    return Row(
      children: <Widget>[
        Text('令'),
        DropdownButton(
          value: selectDeviceId,
          items: deviceItems,
          hint: Text('设备'),
          onChanged: _deviceChange
        ),
        Text('的'),
        DropdownButton(
          value: selectDeviceProperty,
          items: propertyItems,
          hint: Text('属性'),
          onChanged: _propertyChange
        ),
        Text('为'),
        _getValueWidget(getPropertyTypeByProperty(selectDeviceProperty)),
        IconButton(icon: Icon(Icons.close), onPressed: (){widget.onChange(null); close = true; setState(() {});})
      ],
    );
  }
}

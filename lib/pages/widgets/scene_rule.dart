import 'package:flutter/material.dart';
import 'package:app/helper.dart';
import 'package:app/models/device.dart';

class SceneRule extends StatefulWidget {
  SceneRule({Key key, this.rule, this.onChange}) : super(key: key);

  final rule;

  final onChange;

  @override
  _SceneRuleState createState() => _SceneRuleState();
}

class _SceneRuleState extends State<SceneRule> {

  List<DropdownMenuItem<int>> deviceItems = [];

  List<DropdownMenuItem<String>> propertyItems = [];

  List<DropdownMenuItem> operatorItems = [];

  int selectDeviceId;

  String selectDeviceProperty;

  var selectOperator;

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
          if (widget.rule != null && widget.rule['id'] == device['id']) {
            currentDevice = device;
          }
          deviceItems.add(DropdownMenuItem(child: Text(device['name']), value: device['id']));
        }
        setState(() {});
      });
    } else {
      for (var device in devices) {
        if (widget.rule != null && widget.rule['id'] == device['id']) {
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
              DropdownMenuItem(value: true, child: Text('真')),
              DropdownMenuItem(value: false, child: Text('假')),
            ],
            hint: Text('值'),
            onChanged: (currentValue) {
              value = currentValue;
              widget.onChange({
                'id': selectDeviceId,
                'property': selectDeviceProperty,
                'operator': selectOperator,
                'value': value
              });
              setState(() {});
            }
        );
      case PropertyTypes.num:
        var valueField = TextEditingController(text: value);
        return Container(
          width: 140,
          child: TextField(
            controller: valueField,
            onChanged: (text) {
              value = text;
              widget.onChange({
                'id': selectDeviceId,
                'property': selectDeviceProperty,
                'operator': selectOperator,
                'value': value
              });
            }
          )
        );
      case PropertyTypes.time:
        return FlatButton(
          child: value == null ? Text('选择时间') : Text(value.toString()),
          onPressed: () {
            selectDate(context, (TimeOfDay time){
              var hour, minute;
              if (time.minute > 9) {
                minute = time.minute.toString();
              } else {
                minute = '0' + time.minute.toString();
              }
              if (time.hour > 9) {
                hour = time.hour.toString();
              } else {
                hour = '0' + time.hour.toString();
              }
              value = hour + ':' + minute;

              widget.onChange({
                'id': selectDeviceId,
                'property': selectDeviceProperty,
                'operator': selectOperator,
                'value': value
              });
              setState(() {});
            });
          }
        );
      case PropertyTypes.unknown:
        return Text('');
    }
    return Text('');
  }

  void _deviceChange(id) {
    for (var device in devices) {
      if (device['id'] == id) {
        selectDeviceId = id;
        currentDevice = device;
        propertyItems = getDevicePropertiesMenuItemList(device);
        selectDeviceProperty = null;
        selectOperator = null;
        value = null;
        setState(() {});
        break;
      }
    }
    widget.onChange({
      'id': selectDeviceId,
      'property': selectDeviceProperty,
      'operator': selectOperator,
      'value': value
    });
  }

  void _propertyChange(property) {
    selectDeviceProperty = property;
    operatorItems = getOperatorMenuItemListByType(getPropertyTypeByProperty(property));
    selectOperator = null;
    value = null;
    setState(() {});
    widget.onChange({
      'id': selectDeviceId,
      'property': selectDeviceProperty,
      'operator': selectOperator,
      'value': value
    });
  }

  void _operatorChange(operator) {
    selectOperator = operator;
    setState(() {});
    widget.onChange({
      'id': selectDeviceId,
      'property': selectDeviceProperty,
      'operator': selectOperator,
      'value': value
    });
  }
  
  @override
  Widget build(BuildContext context) {
    if (close) {
      return Text('');
    }

    if (widget.rule != null) {
      selectDeviceId = widget.rule['id'];
      selectDeviceProperty = widget.rule['property'];
      selectOperator = widget.rule['operator'];
      value = widget.rule['value'];
      return Column(children: [
        Row(
          children: <Widget>[
            Text('当'),
            DropdownButton(
                value: selectDeviceId,
                items: deviceItems,
                hint: Text('设备'),
                onChanged: _deviceChange
            ),
            Text('的'),
            DropdownButton(
                value: selectDeviceProperty,
                items: getDevicePropertiesMenuItemList(currentDevice),
                hint: Text('属性'),
                onChanged: _propertyChange
            ),
          ],
        ),
        Row(
          children: [
            Text('值'),
            DropdownButton(
                value: selectOperator,
                items: getOperatorMenuItemListByType(getPropertyTypeByProperty(selectDeviceProperty)),
                hint: Text('请选择操作符'),
                onChanged: _operatorChange
            ),
            Expanded(
              child: _getValueWidget(getPropertyTypeByProperty(selectDeviceProperty)),
            ),
            IconButton(icon: Icon(Icons.close), onPressed: (){widget.onChange(null); close = true; setState(() {});}),
          ],
        )
      ]
      );
    }

    return Column(children: [
          Row(
          children: <Widget>[
            Text('当'),
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
          ],
        ),
        Row(
          children: [
            Text('值'),
            DropdownButton(
                value: selectOperator,
                items: operatorItems,
                hint: Text('请选择操作符'),
                onChanged: _operatorChange
            ),
            _getValueWidget(getPropertyTypeByProperty(selectDeviceProperty)),
            IconButton(icon: Icon(Icons.close), onPressed: (){widget.onChange(null); close = true; setState(() {});})
          ],
        )
      ]
    );
  }
}

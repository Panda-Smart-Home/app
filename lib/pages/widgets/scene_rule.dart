import 'package:flutter/material.dart';
import 'package:app/helper.dart';
import 'package:app/models/device.dart';

class SceneRule extends StatefulWidget {
  SceneRule({Key key, this.devices, this.rule}) : super(key: key);

  final devices;

  final rule;

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

  @override
  void initState() {
    for (var device in widget.devices) {
      deviceItems.add(DropdownMenuItem(child: Text(device['name']), value: device['id']));
    }
    super.initState();
  }


  Widget _getValueWidget(PropertyTypes type) {
    var valueField = TextEditingController(text: '');
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
              setState(() {});
            }
        );
      case PropertyTypes.num:
        return Container(
          width: 160,
          child: TextField(controller: valueField, onChanged: (text){value = text;})
        );
      case PropertyTypes.unknown:
        return Text('');
    }
    return Text('');
  }
  
  @override
  Widget build(BuildContext context) {
    return Column( children: [
        Row(
        children: <Widget>[
          Text('当'),
          DropdownButton(
            value: selectDeviceId,
            items: deviceItems,
            hint: Text('设备'),
            onChanged: (id) {
              for (var device in widget.devices) {
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
            }
          ),
          Text('的'),
          DropdownButton(
              value: selectDeviceProperty,
              items: propertyItems,
              hint: Text('属性'),
              onChanged: (property) {
                selectDeviceProperty = property;
                operatorItems = getOperatorMenuItemListByType(getPropertyTypeByProperty(property));
                selectOperator = null;
                value = null;
                setState(() {});
              }
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
              onChanged: (operator) {
                selectOperator = operator;
                setState(() {});
              }
          ),
          _getValueWidget(getPropertyTypeByProperty(selectDeviceProperty))
        ],
      )
    ]
    );
  }
}

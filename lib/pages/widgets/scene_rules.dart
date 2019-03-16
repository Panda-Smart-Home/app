import 'package:flutter/material.dart';
import 'package:app/helper.dart';
import 'package:app/pages/widgets/scene_rule.dart';

class SceneRules extends StatefulWidget {
  SceneRules({Key key, this.rules}) : super(key: key);

  final List rules;

  @override
  _SceneRulesState createState() => _SceneRulesState(rules);
}

class _SceneRulesState extends State<SceneRules> {

  _SceneRulesState(this.rules) : super();

  List rules = [];

  List<Widget> ruleWidgets = [];

  var devices = [];

  @override
  void initState() {
    _buildRules();
    getDevices().then((val) {devices = val;});
    super.initState();
  }

  void _addRule() {
    var rule = {
      'id': null,
      'type': null,
      'property': null,
      'operator': null,
      'value': null,
    };
    rules.add(rule);
    ruleWidgets.add(_buildRule(rule));
    setState(() {
      ruleWidgets = ruleWidgets;
    });
  }

  Widget _buildRule(rule) {
    return SceneRule(devices: devices, rule: rule);
  }

  void _buildRules() {
    ruleWidgets = [];
    ruleWidgets.add(Row(
      children: <Widget>[
        Text('关联规则：'),
        FlatButton(child: Icon(Icons.add), onPressed: (){_addRule();}),
      ],
    ));
    for(var rule in rules) {
      ruleWidgets.add(_buildRule(rule));
    }
    setState(() {
      ruleWidgets = ruleWidgets;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: ruleWidgets
    );
  }
}

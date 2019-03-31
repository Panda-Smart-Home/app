import 'package:flutter/material.dart';
import 'package:app/models/magic.dart';
import 'package:app/pages/widgets/scene_rule.dart';

class SceneRules extends StatefulWidget {
  SceneRules({Key key, this.rules}) : super(key: key);

  final Magic rules;

  void setRules(newRules) {
    rules.content = newRules;
  }

  @override
  _SceneRulesState createState() => _SceneRulesState();
}

class _SceneRulesState extends State<SceneRules> {

  _SceneRulesState() : super();

  List rules = [];

  List<Widget> ruleWidgets = [];

  @override
  void initState() {
    rules = widget.rules.content;
    _buildRules();
    super.initState();
  }

  void _addRule() {
    rules.add(null);
    ruleWidgets.add(_buildRule(null));
    setState(() {});
  }

  Widget _buildRule(rule) {
    var i = rules.indexOf(rule);
    return SceneRule(
      rule: rule,
      onChange: (newRule){rules[i] = newRule;widget.rules.content = rules;},
    );
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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: ruleWidgets
    );
  }
}

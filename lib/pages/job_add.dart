import 'package:flutter/material.dart';
import 'package:app/helper.dart';
import 'package:app/models/job.dart';
import 'package:app/home/widgets/job_card.dart';

class JobAdd extends StatefulWidget {
  JobAdd({Key key}) : super(key: key);

  @override
  _JobAddState createState() => _JobAddState();
}

class _JobAddState extends State<JobAdd> {
  TextEditingController nameController = TextEditingController(text: '');
  TextStyle style =  TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('新建任务'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.check), onPressed: () {
            // TODO
          })
        ],
      ),
      body: ListView(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('任务名称：', style: style),
              Container(
                  width: 240,
                  child: TextField(maxLength: 20, controller: nameController)
              )
            ],
          ),
          Row(
            children: <Widget>[
              Text('关联场景：', style: style),
              // TODO
            ],
          )
        ],
      ),
    );
  }
}

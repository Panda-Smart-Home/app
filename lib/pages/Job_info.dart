import 'package:flutter/material.dart';
import 'package:app/helper.dart';
import 'package:app/models/job.dart';
import 'package:app/home/home.dart';

class JobInfo extends StatelessWidget {

  JobInfo({Key key, this.job}) : super(key: key);

  final Job job;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('任务信息'),
      ),
      body: RefreshIndicator(
        onRefresh: job.refresh,
        child: ListView(
          children: <Widget>[
            Card(
                margin: EdgeInsets.only(left: 12, right: 12, top: 12),
                child: Padding(
                  padding: EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('任务ID: ' + job.id.toString(), style: TextStyle(fontSize: 18)),
                      Text('任务名称: ' + job.name, style: TextStyle(fontSize: 18)),
                      Text('关联场景: ' + job.scene.name, style: TextStyle(fontSize: 18)),
                      Text('关联行为: ' + job.action.name, style: TextStyle(fontSize: 18)),
                    ],
                  ),
                )
            ),
            Padding(
              padding: EdgeInsets.all(14),
              child: MaterialButton(
                child: Text('删除任务', style: TextStyle(color: Colors.white, fontSize: 16)),
                color: Colors.red,
                onPressed: () {
                  askDialog(context, '删除提示', '您确定要删除该任务？', (){
                    job.delete().then((res) {
                      if (res) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
                      } else {
                        dialog(context, '错误', '删除失败');
                      }
                    });
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

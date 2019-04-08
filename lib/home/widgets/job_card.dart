import 'package:flutter/material.dart';
import 'package:app/models/job.dart';
import 'package:app/pages/Job_info.dart';

class JobCard extends StatefulWidget {
  JobCard({Key key, this.job}) : super(key: key);

  final Job job;

  @override
  _JobCardState createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12, right: 12, top: 12),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => JobInfo(job: widget.job)));
        },
        child: Card(
          child: Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 6),
                    child: Icon(Icons.list),
                  ),
                  Text(
                    widget.job.name,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              )
          ),
        ),
      ),
    );
  }
}

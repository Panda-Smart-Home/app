import 'package:flutter/material.dart';

class JobList extends StatefulWidget {
  JobList({Key key}) : super(key: key);

  @override
  _JobListState createState() => _JobListState();
}

class _JobListState extends State<JobList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('Job')),
    );
  }
}

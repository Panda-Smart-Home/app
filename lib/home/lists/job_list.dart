import 'package:flutter/material.dart';
import 'package:app/helper.dart';
import 'package:app/models/job.dart';
import 'package:app/home/widgets/job_card.dart';

class JobList extends StatefulWidget {
  JobList({Key key}) : super(key: key);

  @override
  _JobListState createState() => _JobListState();
}

class _JobListState extends State<JobList> {
  List<JobCard> jobs = [];

  _JobListState() {
    _getJobs();
  }

  Future<Null> _getJobs() async {
    var data = await getJobs();
    List<JobCard> cards = [];

    for (var job in data) {
      cards.add(JobCard(job: Job.fromMap(job)));
    }

    setState(() {
      jobs = cards;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _getJobs,
      child: ListView(
          children: jobs
      ),
    );
  }
}

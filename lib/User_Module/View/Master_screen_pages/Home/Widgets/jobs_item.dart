import 'package:flutter/material.dart';
import 'package:job_scout/User_Module/View/Master_screen_pages/Home/Widgets/icon_text.dart';
import 'package:job_scout/User_Module/models/job.dart';

class JobsItem extends StatelessWidget {
  final Job job;
  final bool showTime;
  JobsItem(this.job, {this.showTime = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.teal,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: Colors,
                    ),
                    child: Image.asset(job.logoUrl),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    job.company,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Icon(
                job.isMark ? Icons.bookmark : Icons.bookmark_add_outlined,
                color: Colors.teal,
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            job.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconText(Icons.location_on_outlined, job.location),
              IconText(Icons.access_time_outlined, job.time)
            ],
          ),
        ],
      ),
    );
  }
}

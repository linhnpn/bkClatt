import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:swd_project_clatt/models/services.dart';
import 'package:swd_project_clatt/models/workers.dart';
import 'package:intl/intl.dart';

import 'package:swd_project_clatt/services/list_feedback_api.dart';

import '../../../models/Feedbackk.dart';

class ReviewCard extends StatefulWidget {
  final Worker worker;
  final Service service;
  final int rate;
  ReviewCard(
      {super.key,
      required this.worker,
      required this.service,
      required this.rate});
  @override
  _ReviewCardState createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  List<Feedbackk> feedback = [];
  late int workerId;
  late int serviceId;
  late int rate;

  @override
  void initState() {
    super.initState;
    workerId = widget.worker.id;
    serviceId = widget.service.id;
    rate = widget.rate;
    fetchReview(workerId, serviceId, rate);
  }

  @override
  void didUpdateWidget(covariant ReviewCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    fetchReview(workerId, serviceId, widget.rate);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          for (int i = 0; i < feedback.length; i++)
            Card(
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(feedback[i].profilePicture),
                              radius: 20,
                            ),
                            const SizedBox(width: 15),
                            Text(
                              feedback[i].usename,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        RatingBarIndicator(
                          rating: feedback[i].rate.toDouble(),
                          itemBuilder: (_, __) => Icon(Icons.star,
                              color: Colors.deepPurple.shade300),
                          itemCount: 5,
                          itemSize: 20,
                          unratedColor: Colors.grey[300],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Text(
                      feedback[i].detail,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[800],
                        height: 1.5,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey[300],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      DateFormat('MMM d, yyyy | hh:mm aaa')
                          .format(feedback[i].timestamp),
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                ],
              ),
            )
        ]);
  }

  void fetchReview(int workerId, int serviceId, int rate) async {
    final listFeedback =
        await FeedBackApi.fetchFeedback(workerId, serviceId, rate);
    setState(() {
      // ignore: unnecessary_null_comparison
      if (listFeedback != null) {
        feedback = listFeedback;
      } else {
        print("list feedback null");
      }
    });
  }
}

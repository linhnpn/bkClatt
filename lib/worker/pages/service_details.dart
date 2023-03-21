import 'package:flutter/material.dart';
import 'package:swd_project_clatt/models/services.dart';
import 'package:swd_project_clatt/user/components/worker_details/review_card.dart';
import 'package:swd_project_clatt/models/workers.dart';

import '../../models/Feedbackk.dart';

class ServiceDetailsScreen extends StatefulWidget {
  final Worker worker;
  final Service service;
  const ServiceDetailsScreen({required this.worker, required this.service});

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Feedbackk> feedbacks = [];

  @override
  void initState() {
    _tabController = TabController(length: 6, vsync: this, initialIndex: 0);
    _tabController.addListener((_handleTabSelection));
    super.initState();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 25, right: 25),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(width: 15),
                    Text(widget.service.name),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Image.asset(
                      widget.worker.image,
                      width: 170,
                      height: 170,
                      fit: BoxFit.contain,
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.worker.name,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.deepPurple.shade300,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.star_half_outlined,
                                  size: 15,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "4.9",
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "(100 reviews)",
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.cleaning_services_sharp,
                                  color: Colors.deepPurple.shade300,
                                  size: 15,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  widget.service.name,
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_sharp,
                                  color: Colors.deepPurple.shade300,
                                  size: 15,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  widget.worker.address,
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "\$${widget.worker.price}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple.shade300,
                              ),
                            ),
                            const SizedBox(height: 10),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                height: MediaQuery.of(context).size.height / 18,
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple.shade300,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Book now",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        letterSpacing: 1),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Divider(
                  thickness: 0.5,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 5),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "About me",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.worker.introduce,
                        style: TextStyle(
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star_half_outlined,
                            size: 20,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "4.9",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            "(100 reviews)",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      TabBar(
                          controller: _tabController,
                          isScrollable: true,
                          unselectedLabelColor: Colors.deepPurple.shade300,
                          indicator: BoxDecoration(
                            color: Colors.deepPurple.shade300,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          indicatorPadding:
                              const EdgeInsets.symmetric(vertical: 8.0),
                          labelPadding:
                              const EdgeInsets.symmetric(horizontal: 0),
                          tabs: [
                            Tab(
                                child: Container(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: Colors.deepPurple.shade300,
                                      width: 2)),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 16.3,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    "All",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            )),
                            Tab(
                                child: Container(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: Colors.deepPurple.shade300,
                                      width: 2)),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 16.3,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    "5",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            )),
                            Tab(
                                child: Container(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: Colors.deepPurple.shade300,
                                      width: 2)),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 16.3,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    "4",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            )),
                            Tab(
                                child: Container(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: Colors.deepPurple.shade300,
                                      width: 2)),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 16.3,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    "3",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            )),
                            Tab(
                                child: Container(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: Colors.deepPurple.shade300,
                                      width: 2)),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 16.3,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    "2",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            )),
                            Tab(
                                child: Container(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: Colors.deepPurple.shade300,
                                      width: 2)),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 16.3,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    "1",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                            )),
                          ]),
                      const SizedBox(height: 5),
                      Center(
                        child: [
                          ReviewCard(
                              worker: widget.worker,
                              service: widget.service,
                              rate: 10),
                          ReviewCard(
                              worker: widget.worker,
                              service: widget.service,
                              rate: 5),
                          ReviewCard(
                              worker: widget.worker,
                              service: widget.service,
                              rate: 4),
                          ReviewCard(
                              worker: widget.worker,
                              service: widget.service,
                              rate: 3),
                          ReviewCard(
                              worker: widget.worker,
                              service: widget.service,
                              rate: 2),
                          ReviewCard(
                              worker: widget.worker,
                              service: widget.service,
                              rate: 1),
                          //getFeedbacks(feedbacks),
                        ][_tabController.index],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 105,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            Divider(
              thickness: 0.5,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.3,
                    height: MediaQuery.of(context).size.height / 14,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: Colors.deepPurple.shade300,
                        width: 2.5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Stop service",
                        style: TextStyle(
                            color: Colors.deepPurple.shade300,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.3,
                    height: MediaQuery.of(context).size.height / 14,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade300,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Center(
                      child: Text(
                        "Edit profile",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

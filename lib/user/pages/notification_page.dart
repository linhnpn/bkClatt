import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 25, right: 25),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Notification",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              radius: 13.0,
                              backgroundColor: Colors.deepPurple.shade200,
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Flexible(
                            child: Text(
                              "Your booking #1234 has been approved by Lisa to upcoming",
                              textAlign: TextAlign.justify,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(4.5),
                            decoration: BoxDecoration(
                              color: Colors.lightBlue.shade50,
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              radius: 20.0,
                              backgroundColor: Colors.lightBlue.shade50,
                              child: Icon(
                                Icons.cancel,
                                color: Colors.redAccent,
                                size: 30,
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Flexible(
                            child: Text(
                              "Your booking #1205 has been rejected from Lisa Your booking #1205 has been rejected from Lisa",
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.greenAccent.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              radius: 13.0,
                              backgroundColor: Colors.greenAccent.shade200,
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Flexible(
                            child: Text(
                              "Your service #1234 has been completed Your service #1234 has been completed",
                              textAlign: TextAlign.justify,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(4.5),
                            decoration: BoxDecoration(
                              color: Colors.lightBlue.shade50,
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              radius: 20.0,
                              backgroundColor: Colors.lightBlue.shade50,
                              child: Icon(
                                Icons.cancel,
                                color: Colors.redAccent,
                                size: 30,
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Flexible(
                            child: Text(
                              "Your booking #1205 has been cancelled by Lisa. Your booking #1205 has been cancelled by Lisa",
                              textAlign: TextAlign.justify,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(4.5),
                            decoration: BoxDecoration(
                              color: Colors.lightBlue.shade50,
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              radius: 20.0,
                              backgroundColor: Colors.lightBlue.shade50,
                              child: Icon(
                                Icons.cancel,
                                color: Colors.redAccent,
                                size: 30,
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Flexible(
                            child: Text(
                              "You have cancelled your booking #1205. You have cancelled your booking #1205",
                              textAlign: TextAlign.justify,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}

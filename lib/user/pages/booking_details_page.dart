import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:swd_project_clatt/models/workers.dart';
import 'package:swd_project_clatt/services/create_booking_api.dart';
import 'package:table_calendar/table_calendar.dart';

import '../components/user_screens.dart';

import '../../models/account.dart';

class BookingDetailsScreen extends StatefulWidget {
  final Worker worker;

  const BookingDetailsScreen({super.key, required this.worker});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  DateTime today = DateTime.now();
  int _counter = 1;
  TimeOfDay _selectedTime = TimeOfDay.now();

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    if (_counter >= 1) {
      setState(() {
        _counter--;
      });
    }
  }

  Future<void> _createBookingOrder() async {
    final storage = FlutterSecureStorage();
    final jsonString = await storage.read(key: 'account');

// Convert JSON string to object
    final accountJson = jsonDecode(jsonString!);
    final account = Account.fromJson(accountJson);

    int userId = account.id;
    // int workerId = 2;
    DateTime workDateTime = DateTime(
      today.year,
      today.month,
      today.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );
    String address = account.location;
    String desciption = "Nothing to add";
    String status = "unconfirm";
    bool check = workDateTime.isAfter(DateTime.now());
    if (check) {
      // Make the API call using the http package
      final response = await BookingApi.fetchWorkerByService(
          userId,
          widget.worker.id,
          widget.worker.jobId,
          workDateTime.toIso8601String(),
          address,
          DateTime.now().toIso8601String(),
          status,
          desciption,
          _counter);

      // Check if the API call was successful
      if (response == 202) {
        // Booking order was created successfully, show a success message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Booking order created successfully!')),
        );
        // Navigator.pop(context);
        // Navigate to the UserScreens and remove all previous screens from the stack
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => UserScreens(
              account: account,
            ),
          ),
          (route) => false, // remove all previous routes
        );
      } else {
        // Booking order creation failed, show an error message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create booking order')),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Failed!!'),
          content: Text('Can\'t book date in the past!!!.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    Text(
                      "Booking Details",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Text(
                  "Select Date",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TableCalendar(
                    firstDay: DateTime.utc(2023),
                    focusedDay: today,
                    lastDay: DateTime.utc(2024),
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleTextStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: TextStyle(fontWeight: FontWeight.bold),
                        weekendStyle: TextStyle(fontWeight: FontWeight.bold)),
                    availableGestures: AvailableGestures.all,
                    onDaySelected: _onDaySelected,
                    selectedDayPredicate: (day) => isSameDay(day, today),
                    calendarStyle: CalendarStyle(
                      outsideDaysVisible: false,
                      weekendTextStyle: TextStyle(color: Colors.black),
                      todayDecoration: BoxDecoration(
                        color: Colors.deepPurple.shade200,
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: Colors.deepPurple.shade300,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Working Hours",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                      Container(
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: CircleAvatar(
                                radius: 15.0,
                                backgroundColor: Colors.deepPurple.shade100,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                  onPressed: _decrementCounter,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '$_counter',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: CircleAvatar(
                                radius: 15.0,
                                backgroundColor: Colors.deepPurple.shade100,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                  onPressed: _incrementCounter,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "Choose Start Time",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: SizedBox(
                      height: 30,
                      child: Row(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 9, // number of hours
                              itemBuilder: (context, index) {
                                final hour = index + 9; // start at 9:00 AM
                                final time = TimeOfDay(hour: hour, minute: 0);
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedTime = time;
                                    });
                                  },
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 5, 10, 5),
                                      decoration: BoxDecoration(
                                          color: _selectedTime == time
                                              ? Colors.deepPurple.shade300
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                              color: Colors.deepPurple.shade300,
                                              width: 2)),
                                      child: Text(
                                        time.format(context),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: _selectedTime == time
                                              ? Colors.white
                                              : Colors.deepPurple.shade300,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 16),
                        ],
                      ),
                    )),
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
            InkWell(
              onTap: _createBookingOrder,
              child: Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 14,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade300,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Center(
                  child: Text(
                    "Book now",
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
      ),
    );
  }
}

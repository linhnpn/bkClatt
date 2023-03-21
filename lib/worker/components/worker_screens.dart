import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:swd_project_clatt/models/account.dart';
import 'package:swd_project_clatt/worker/pages/home_page.dart';
import 'package:swd_project_clatt/worker/pages/my_bookings_page.dart';
import 'package:swd_project_clatt/worker/pages/notification_page.dart';
import 'package:swd_project_clatt/worker/pages/profile_page.dart';

class WorkerScreens extends StatefulWidget {
  final Account account;
  const WorkerScreens({super.key, required this.account});

  @override
  State<WorkerScreens> createState() => _WorkerScreensState();
}

class _WorkerScreensState extends State<WorkerScreens> {
  String? mtoken = " ";
  int _selectedIndex = 0;

  late List<Widget> _screenOptions;

  @override
  void initState() {
    super.initState();
    requestPermission();
    _screenOptions = <Widget>[
      HomeScreen(account: widget.account),
      MyBookingsScreen(),
      NotificationScreen(),
      ProfileScreen(),
    ];
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mtoken = token;
        print("My token is $mtoken");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screenOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        child: SafeArea(
            child: GNav(
          backgroundColor: Colors.deepPurple.shade300,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.deepPurple.shade400,
          gap: 8,
          padding: const EdgeInsets.all(16),
          tabMargin: const EdgeInsetsDirectional.all(8),
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          tabs: const [
            GButton(
              icon: Icons.home_outlined,
              text: 'Home',
            ),
            GButton(
              icon: Icons.calendar_today_outlined,
              text: 'Booking',
            ),
            GButton(
              icon: Icons.notifications_none_outlined,
              text: 'Notification',
            ),
            GButton(
              icon: Icons.person_outline,
              text: 'Profile',
            ),
          ],
        )),
      ),
    );
  }
}

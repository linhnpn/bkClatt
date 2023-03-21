import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:swd_project_clatt/models/account.dart';
import 'package:swd_project_clatt/user/pages/home_page.dart';
import 'package:swd_project_clatt/user/pages/my_bookings_page.dart';
import 'package:swd_project_clatt/user/pages/notification_page.dart';
import 'package:swd_project_clatt/user/pages/profile_page.dart';

import '../../services/list_services_api.dart';

class UserScreens extends StatefulWidget {
  final Account account;
  const UserScreens({super.key, required this.account});

  @override
  State<UserScreens> createState() => _UserScreensState();
}

class _UserScreensState extends State<UserScreens> {
  String? mtoken = " ";
  int _selectedIndex = 0;

  late List<Widget> _screenOptions;

  @override
  void initState() {
    super.initState();
    requestPermission();
    _screenOptions = <Widget>[
      HomePage(account: widget.account),
      MyBookingsScreen(),
      NotificationScreen(),
      ProfileScreen(),
    ];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getToken();
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
        updateFcmToken();
        // print("My token is $mtoken");
      });
    });
  }

  Future<void> updateFcmToken() async {
    int userId = 2;
    await ServicesApi.updateFcmToken(userId, mtoken!);
    setState(() {});
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

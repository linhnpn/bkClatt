import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:swd_project_clatt/models/account.dart';
import 'package:swd_project_clatt/user/components/home/banner_slider.dart';
import 'package:swd_project_clatt/models/services.dart';

import '../../services/list_services_api.dart';

class HomeScreen extends StatefulWidget {
  final Account account;
  const HomeScreen({super.key, required this.account});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Service> services = [];
  List<Service> empService = [];

  @override
  void initState() {
    super.initState();
    fetchServices();
    fetchServicesEmp(widget.account);
  }

  bool _checkJobEmp(Service service, List<Service> empService) {
    for (var i = 0; i < empService.length; i++) {
      if (service.id == empService[i].id) {
        return true;
      }
    }
    return false;
  }

  Widget _buildConfirmationRegisterDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Confirmation'),
      content: Text('Are you sure you want to register this service?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text('Register'),
        ),
      ],
    );
  }

  Widget _buildConfirmationUnRegisterDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Confirmation'),
      content: Text('Are you sure you want to unregister this service?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text('Un-Register'),
        ),
      ],
    );
  }

  Future<void> registerNewJob(int jobId) async {
    final storage = FlutterSecureStorage();
    final jsonString = await storage.read(key: 'account');

    final accountJson = jsonDecode(jsonString!);
    final account = Account.fromJson(accountJson);

    int userId = account.id;
    final statusResponse = await ServicesApi.registerNewJob(userId, jobId);
    if (statusResponse == 202) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Success!'),
          content: Text('Register a new job successfully!!!.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Failed!'),
          content: Text('Register a new job fail!!!.'),
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

  Future<void> unregisterJob(int jobId) async {
    final storage = FlutterSecureStorage();
    final jsonString = await storage.read(key: 'account');

    final accountJson = jsonDecode(jsonString!);
    final account = Account.fromJson(accountJson);

    int userId = account.id;
    final statusResponse = await ServicesApi.unregisterJob(userId, jobId);
    if (statusResponse == 202) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Success!'),
          content: Text('Unregister a new job successfully!!!.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Failed!'),
          content: Text('Unregister a new job fail!!!.'),
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

  Future<void> fetchServices() async {
    final listServices = await ServicesApi.fetchServices();
    setState(() {
      if (listServices != null) {
        services = listServices;
      } else {}
    });
  }

  Future<void> fetchServicesEmp(Account account) async {
    final listServices = await ServicesApi.fetchServicesEmp(account.id);
    setState(() {
      if (listServices != null) {
        empService = listServices;
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: ListView(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage:
                      NetworkImage('${widget.account.profilePicture}'),
                  radius: 25,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Hello, ",
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            widget.account.fullname,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_sharp,
                            color: Colors.deepPurple.shade300,
                            size: 16,
                          ),
                          SizedBox(width: 5),
                          Text(
                            widget.account.location,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "What's news?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 5),
            Center(child: BannerSlider()),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Service",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            GridView.count(
              crossAxisCount: 3,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              childAspectRatio: (80 / 70),
              children: [
                for (int i = 0; i < services.length; i++)
                  Container(
                    child: Column(children: [
                      InkWell(
                        onTap: () async {
                          bool check = _checkJobEmp(services[i], empService);
                          if (check) {
                            bool confirm = await showDialog(
                              context: context,
                              builder: (context) =>
                                  _buildConfirmationUnRegisterDialog(context),
                            );
                            if (confirm) {
                              unregisterJob(services[i].id);
                            }
                          } else {
                            bool confirm = await showDialog(
                              context: context,
                              builder: (context) =>
                                  _buildConfirmationRegisterDialog(context),
                            );
                            if (confirm) {
                              registerNewJob(services[i].id);
                            }
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          child: Image.network(
                            services[i].icon,
                            width: 100,
                            height: 60,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          services[i].name,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ]),
                  ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}

import 'dart:convert';

import 'package:swd_project_clatt/common/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/bookings.dart';

class BookingApi {
  static Future<int> fetchWorkerByService(
      int userId,
      int empId,
      int jobId,
      String workDate,
      String address,
      String timestamp,
      String status,
      String desciption,
      int workTime) async {
    final url =
        '$BASE_URL/booking/create-booking?userId=$userId&employeeId=$empId&jobId=$jobId&timestamp=$timestamp&address_id=$address&status=$status&description=$desciption&workTime=$workTime&workDate=$workDate';
    final uri = Uri.parse(url);
    final storage = new FlutterSecureStorage();
    String? accessToken = await storage.read(key: 'accessToken');
    final response =
        await http.post(uri, headers: {'Authorization': 'Bearer $accessToken'});
    final body = response.statusCode;
    return body;
  }

  static Future<List<Booking>> fetchBooking(
    int userId,
    String status,
  ) async {
    final url =
        '$BASE_URL/booking/get-bookings?status=$status&user_id=${userId}';

    final uri = Uri.parse(url);
    final storage = new FlutterSecureStorage();
    String? accessToken = await storage.read(key: 'accessToken');
    final response =
        await http.post(uri, headers: {'Authorization': 'Bearer $accessToken'});
    final body = response.body;
    final json = jsonDecode(body);
    final users = json['data'] as List<dynamic>;
    final booking = await users.map((e) {
      return Booking(
        id: e['id'],
        userId: e['userId'],
        usename: e['userName'],
        empId: e['empId'],
        empName: e['empName'],
        price: e['price'],
        workTime: e['workTime'],
        description: e['description'],
        jobImage: e['jobImage'],
        jobId: e['jobId'],
        jobName: e['jobName'],
        location: e['location'],
        status: e['status'],
        timestamp: DateTime.parse(e['timestamp']),
      );
    }).toList();
    return booking;
  }

  static Future<int> changeStatusBooking(
    int bookingId,
    String status,
  ) async {
    final url = '$BASE_URL/booking/update-status/$bookingId?status=$status';
    final uri = Uri.parse(url);
    final storage = new FlutterSecureStorage();
    String? accessToken = await storage.read(key: 'accessToken');
    final response =
        await http.put(uri, headers: {'Authorization': 'Bearer $accessToken'});
    final statusCode = response.statusCode;
    return statusCode;
  }

  static Future<List<Booking>> fetchBookingEmp(
    int userId,
    String status,
  ) async {
    final url =
        '$BASE_URL/booking/get-bookings?status=$status&employee_id=${userId}';

    final uri = Uri.parse(url);
    final storage = new FlutterSecureStorage();
    String? accessToken = await storage.read(key: 'accessToken');
    final response =
        await http.post(uri, headers: {'Authorization': 'Bearer $accessToken'});
    final body = response.body;
    final json = jsonDecode(body);
    final users = json['data'] as List<dynamic>;
    final booking = await users.map((e) {
      return Booking(
        id: e['id'],
        userId: e['userId'],
        usename: e['userName'],
        empId: e['empId'],
        empName: e['empName'],
        price: e['price'],
        workTime: e['workTime'],
        description: e['description'],
        jobImage: e['jobImage'],
        jobId: e['jobId'],
        jobName: e['jobName'],
        location: e['location'],
        status: e['status'],
        timestamp: DateTime.parse(e['timestamp']),
      );
    }).toList();
    return booking;
  }
}

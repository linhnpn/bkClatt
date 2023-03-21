import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:swd_project_clatt/common/constants.dart';
import 'package:http/http.dart' as http;
import '../models/Feedbackk.dart';

class FeedBackApi {
  static Future<int> fetchWorkerByService(
      int id,
      int rate,
      int user_id,
      int employeeId,
      String detail,
      String profilePicture,
      String usename,
      String timestamp) async {
    final url =
        '$BASE_URL/feedback/FeedBackApi?userId=26&employeeId=25&jobId=6&timestamp=$timestamp&rate=$rate&detail=$detail&profilePicture=$profilePicture&usename=$usename&id=$id';
    final uri = Uri.parse(url);
    final storage = new FlutterSecureStorage();
    String? accessToken = await storage.read(key: 'accessToken');
    final response =
        await http.post(uri, headers: {'Authorization': 'Bearer $accessToken'});
    final body = response.statusCode;
    return body;
  }

  static Future<List<Feedbackk>> fetchFeedback(
      int employee_id, int job_id, int rate) async {
    String rateId = "";
    if (rate == 10) {
      rateId = "";
    } else {
      rateId = rate.toString();
    }
    final url =
        '$BASE_URL/feedback/get-feedbacks?employee_id=$employee_id&job_id=$job_id&rate=$rateId';
    final uri = Uri.parse(url);
    final storage = new FlutterSecureStorage();
    String? accessToken = await storage.read(key: 'accessToken');
    final response =
        await http.post(uri, headers: {'Authorization': 'Bearer $accessToken'});
    final body = response.body;
    final json = jsonDecode(body);
    final feedback = json['data'] as List<dynamic>;
    final feedbacks = await feedback.map((e) {
      return Feedbackk(
        id: e['id'],
        rate: e['rate'],
        user_id: e['user_id'],
        employeeId: e['employee_id'],
        detail: e['detail'],
        profilePicture: e['profilePicture'],
        usename: e['userName'],
        timestamp: DateTime.parse(e['timestamp']),
      );
    }).toList();
    return feedbacks;
  }

  static Future<int> createFeedback(
      int orderId, String detail, int rate) async {
    final url =
        '$BASE_URL/feedback/create-feedback/$orderId?detail=$detail&rate=$rate';
    final uri = Uri.parse(url);
    final storage = new FlutterSecureStorage();
    String? accessToken = await storage.read(key: 'accessToken');
    final response =
        await http.post(uri, headers: {'Authorization': 'Bearer $accessToken'});
    final body = response.statusCode;
    return body;
  }
}

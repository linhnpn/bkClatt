import 'dart:convert';
import 'package:swd_project_clatt/common/constants.dart';
import 'package:swd_project_clatt/models/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ServicesApi {
  static Future<List<Service>?> fetchServices() async {
    try {
      const url = '$BASE_URL/job/get-jobs';
      final storage = new FlutterSecureStorage();
      String? accessToken = await storage.read(key: 'accessToken');
      final uri = Uri.parse(url);
      final response = await http
          .post(uri, headers: {'Authorization': 'Bearer $accessToken'});
      final body = response.body;
      final json = jsonDecode(body);

      final users = json['data'] as List<dynamic>;

      final services = await users.map((e) {
        return Service(
          id: e['id'],
          name: e['jobName'],
          icon: e['thumbnailImage'],
          price: e['price'],
        );
      }).toList();
      return services;
    } catch (e) {
      return null;
    }
  }

  static Future<int> updateFcmToken(
    int accountId,
    String fcmToken,
  ) async {
    final url =
        '$BASE_URL/account/update-fcm-token?account_id=$accountId&fcmToken=$fcmToken';
    final uri = Uri.parse(url);
    final storage = new FlutterSecureStorage();
    String? accessToken = await storage.read(key: 'accessToken');
    final response =
        await http.put(uri, headers: {'Authorization': 'Bearer $accessToken'});
    final statusCode = response.statusCode;
    return statusCode;
  }

  static fetchServicesEmp(int id) async {
    try {
      final url = '$BASE_URL/job/get-job-by-emp?employee_id=$id';
      final storage = new FlutterSecureStorage();
      String? accessToken = await storage.read(key: 'accessToken');
      final uri = Uri.parse(url);
      final response = await http
          .get(uri, headers: {'Authorization': 'Bearer $accessToken'});
      final body = response.body;
      final json = jsonDecode(body);

      final users = json['data'] as List<dynamic>;

      final services = await users.map((e) {
        return Service(
          id: e['id'],
          name: e['jobName'],
          icon: e['thumbnailImage'],
          price: e['price'],
        );
      }).toList();
      return services;
    } catch (e) {
      return null;
    }
  }

  static Future<int> registerNewJob(
    int accountId,
    int jobId,
  ) async {
    final url =
        '$BASE_URL/job/register-job?job_id=$jobId&employee_id=$accountId';
    final uri = Uri.parse(url);
    final storage = new FlutterSecureStorage();
    String? accessToken = await storage.read(key: 'accessToken');
    final response =
        await http.post(uri, headers: {'Authorization': 'Bearer $accessToken'});
    final statusCode = response.statusCode;
    return statusCode;
  }

  static Future<int> unregisterJob(
    int accountId,
    int jobId,
  ) async {
    final url =
        '$BASE_URL/job/unregister-job?job_id=$jobId&employee_id=$accountId';
    final uri = Uri.parse(url);
    final storage = new FlutterSecureStorage();
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http
        .delete(uri, headers: {'Authorization': 'Bearer $accessToken'});
    final statusCode = response.statusCode;
    return statusCode;
  }
}

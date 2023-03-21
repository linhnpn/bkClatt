import 'dart:convert';
import 'package:swd_project_clatt/common/constants.dart';
import 'package:swd_project_clatt/models/workers.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class WorkerAPI {
  static Future<List<Worker>> fetchWorkerByService(int serviceId) async {
    final url = '$BASE_URL/worker/$serviceId';
    final storage = new FlutterSecureStorage();
    String? accessToken = await storage.read(key: 'accessToken');
    final uri = Uri.parse(url);
    final response =
        await http.get(uri, headers: {'Authorization': 'Bearer $accessToken'});
    final body = response.body;
    final json = jsonDecode(body);
    final users = json['data'] as List<dynamic>;
    final services = await users.map((e) {
      return Worker(
        id: e['empId'],
        jobEmpId: e['jobEmpId'],
        jobId: e['jobId'],
        name: e['empName'],
        image: e['srcPicture'],
        introduce: e['description'],
        countRate: e['countRate'],
        averageRate: e['averageRate'],
        jobName: e['jobName'],
        address: e['location'],
        price: e['priceJob'],
      );
    }).toList();
    return services;
  }
}

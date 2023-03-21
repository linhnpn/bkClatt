import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:swd_project_clatt/models/district.dart';
import 'package:swd_project_clatt/models/province.dart';

import '../common/constants.dart';
import 'package:http/http.dart' as http;

class AccountAPI {
  static Future<int> createNewAccount(
      String username,
      String password,
      String role,
      String dateOfBirth,
      String email,
      String fullname,
      String gender,
      String phone,
      String address,
      int districtId) async {
    final url = '$BASE_URL/login/createAccount';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'password': password,
        'role': role,
        'dateOfBirth': dateOfBirth,
        'email': email,
        'fullname': fullname,
        'gender': gender,
        'phone': phone,
        'addressDescription': address,
        'districtId': districtId
      }),
    );
    return response.statusCode;
  }

  static Future<List<Province>?> fetchProvinces() async {
    try {
      const url = '$BASE_URL/province/all';
      final storage = new FlutterSecureStorage();
      String? accessToken = await storage.read(key: 'accessToken');
      final uri = Uri.parse(url);
      final response = await http
          .get(uri, headers: {'Authorization': 'Bearer $accessToken'});
      final body = response.body;
      final list = jsonDecode(body) as List<dynamic>;
      final provinces = await list.map((e) {
        return Province(
            province_id: e['province_id'].toString(),
            provinceName: e['provinceName']);
      }).toList();
      return provinces;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<List<District>?> fetchDistricts(String provinceId) async {
    try {
      final url = '$BASE_URL/district/$provinceId';
      final storage = new FlutterSecureStorage();
      String? accessToken = await storage.read(key: 'accessToken');
      final uri = Uri.parse(url);
      final response = await http
          .get(uri, headers: {'Authorization': 'Bearer $accessToken'});
      final body = response.body;
      final json = jsonDecode(body);

      final list = json['data'] as List<dynamic>;

      final provinces = await list.map((e) {
        return District(
            district_id: e['district_id'].toString(),
            districtName: e['districtName']);
      }).toList();
      return provinces;
    } catch (e) {
      return null;
    }
  }
}

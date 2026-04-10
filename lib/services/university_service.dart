import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:universities_app/models/university.dart';

class UniversityService {
  final String baseUrl = 'https://tyba-assets.s3.amazonaws.com/FE-Engineer-test/universities.json';

  Future<List<University>> fetchUniversities() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((json) => University.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load universities');
    }
  }
}
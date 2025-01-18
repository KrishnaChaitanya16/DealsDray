import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class FetchCategory {
  static const String _baseUrl = 'http://devapiv4.dealsdray.com/api/v2/user/home/withoutPrice';

  // Fetch the category data from the API
  Future<List<Map<String, String>>> fetchCategory() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<Map<String, String>> categories = [];

      // Check for specific category fields in the response
      if (data['data']['category'] != null) {
        for (var category in data['data']['category']) {
          categories.add({
            'label': category['label'],
            'icon': category['icon'],
          });
        }
      }
      print(categories);
      return categories;
    } else {
      throw Exception('Failed to load categories');
    }
  }
}

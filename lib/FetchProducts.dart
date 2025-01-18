import 'dart:convert';
import 'package:http/http.dart' as http;

class FetchProducts {
  static const String _baseUrl = 'http://devapiv4.dealsdray.com/api/v2/user/home/withoutPrice';

  // Fetch the products from the API
  Future<List<Map<String, String>>> fetchProducts() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<Map<String, String>> products = [];

      // Check for specific product fields in the response
      if (data['data']['products'] != null) {
        for (var product in data['data']['products']) {
          products.add({
            'icon': product['icon'],
            'offer': product['offer'],
            'label': product['label'],
            'subLabel': product['SubLabel'] ?? product['Sublabel'], // Handle both cases
          });
        }
      }

      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
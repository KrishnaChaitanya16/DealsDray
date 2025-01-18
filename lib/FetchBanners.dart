import 'dart:convert';
import 'package:http/http.dart' as http;

class FetchBanners {
  static const String _baseUrl = 'http://devapiv4.dealsdray.com/api/v2/user/home/withoutPrice';

  // Fetch the banner images from the API
  Future<List<String>> fetchBannerImages() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      List<String> bannerImages = [];

      // Check for specific banner fields in the response
      if (data['data']['banner_one'] != null) {
        for (var banner in data['data']['banner_one']) {
          bannerImages.add(banner['banner']);
        }
      }
      if (data['data']['banner_two'] != null) {
        for (var banner in data['data']['banner_two']) {
          bannerImages.add(banner['banner']);
        }
      }
      if (data['data']['banner_three'] != null) {
        for (var banner in data['data']['banner_three']) {
          bannerImages.add(banner['banner']);
        }
      }

      print(bannerImages);
      return bannerImages;
    } else {
      throw Exception('Failed to load banners');
    }
  }
}
import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceIdGenerator {
  static const String fixedDeviceId = '62b43472c84bb6dac82e0504'; // Fixed device ID

  // Function to generate or retrieve the fixed device ID
  static Future<String> generateDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedDeviceId = prefs.getString('deviceId');

    if (storedDeviceId == null) {
      // Store the fixed device ID for future use
      await prefs.setString('deviceId', fixedDeviceId);
      print('Stored fixed device ID: $fixedDeviceId');
      return fixedDeviceId;
    }

    print('Retrieved stored device ID: $storedDeviceId');
    return storedDeviceId;
  }
}

class LoginApi {
  static const String fixedUserId = '62b43472c84bb6dac82e0504'; // Fixed user ID
  static const int maxRetries = 3;
  static const Duration requestTimeout = Duration(seconds: 5);

  // Function to get the fixed device ID
  static Future<String> getDeviceId() async {
    final deviceId = await DeviceIdGenerator.generateDeviceId();
    print('Using device ID: $deviceId');
    return deviceId;
  }

  // Function to send the login code request with retries and timeout handling
  static Future<bool> sendCode(String mobileNumber) async {
    for (int attempt = 1; attempt <= maxRetries; attempt++) {
      try {
        print('Attempt $attempt: Sending code request for mobile number: $mobileNumber');
        final deviceId = await getDeviceId();

        final payload = {
          "mobileNumber": mobileNumber,
          "deviceId": "62b43472c84bb6dac82e0504", // Use the fixed device ID
          "userId": fixedUserId, // Use the fixed user ID
        };

        final response = await http
            .post(
          Uri.parse('http://devapiv4.dealsdray.com/api/v2/user/otp'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(payload),
        )
            .timeout(requestTimeout);

        print('Response status code: ${response.statusCode}');
        if (response.statusCode == 200) {
          print('OTP sent successfully.');
          return true;
        } else {
          print('Failed to send OTP. Status code: ${response.statusCode}');
        }
      } catch (e) {
        print('Error in attempt $attempt: $e');
        if (attempt == maxRetries) {
          print('All retry attempts failed.');
          return false;
        }
        print('Retrying...');
      }
    }
    return false;
  }
}

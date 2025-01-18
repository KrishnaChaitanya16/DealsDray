import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OtpVerificationApi {
  static const String apiUrl = 'http://devapiv4.dealsdray.com/api/v2/user/otp/verification';
  static const String fixedDeviceId = '62b43472c84bb6dac82e0504';
  static const String fixedUserId = '62b43547c84bb6dac82e0525';

  // Function to verify OTP
  static Future<bool> verifyOtp(String otp) async {
    try {
      print('Verifying OTP...');

      // Prepare the payload
      final payload = {
        "otp": otp,
        "deviceId": fixedDeviceId,
        "userId": fixedUserId,
      };

      // Make the POST request
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        print('OTP verification successful.');
        return true;
      } else {
        print('OTP verification failed. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error during OTP verification: $e');
      return false;
    }
  }
}

// Example usage


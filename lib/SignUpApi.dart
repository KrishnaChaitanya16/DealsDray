import 'dart:convert';
import 'package:http/http.dart' as http;

class SignUpApi {
  static const String baseUrl = 'http://devapiv4.dealsdray.com/api/v2/user/email/referral';

  // Function to handle the sign-up request
  static Future<bool> signUp({
    required String email,
    required String password,
    int? referralCode, // Optional referralCode
    required String userId,
  }) async {
    try {
      print('Starting sign-up process...');

      // Prepare the payload dynamically
      final payload = {
        "email": email,
        "password": password,
        "userId": userId,
      };

      // Add referralCode only if it is provided
      if (referralCode != null) {
        payload["referralCode"] = referralCode.toString(); // Convert to String
      }

      print('Request Payload: $payload');

      // Send the POST request
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      // Parse the response
      if (response.statusCode == 202) {
        // Successfully signed up
        print('Sign-up successful.');
        return true;
      } else {
        // Server returned an error
        print('Sign-up failed. Status Code: ${response.statusCode}');
        final responseData = jsonDecode(response.body);
        print('Error Response: $responseData');
        return false;
      }
    } catch (e) {
      print('Error during sign-up: $e');
      return false; // Failure due to exception
    }
  }
}
